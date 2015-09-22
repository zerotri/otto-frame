#!/bin/bash

IMAGE="output/images/rpi-sdimg.img"
STAK_SUPPORT="board/raspberrypi/stak"
FDISK=`which fdisk`
KPARTX=`which kpartx`
MKFS_EXT4=`which mkfs.ext4`
MKFS_VFAT=`which mkfs.vfat`
TAR=`which tar`
CP=`which cp`
DD=`which dd`
MOUNT=`which mount`
UMOUNT=`which umount`
S3CMD=`which s3cmd`

RECOVERY_BOOT_DIR=output/sd_card/boot-recovery
BOOT_DIR=output/sd_card/boot
ROOT_DIR=output/sd_card/root

TARGETDIR="$1"
FWUPCONF_NAME="stak-pi-fw.conf"

PROJECT_ROOT="$TARGETDIR/../.."

FWUP="${PROJECT_ROOT}/output/host/usr/bin/fwup"

FWUP_CONFIG="${PROJECT_ROOT}/board/raspberrypi/stak/$FWUPCONF_NAME"

FW_PATH="${PROJECT_ROOT}/output/images/raspberrypi.fw"
IMG_PATH="${PROJECT_ROOT}/${IMAGE}"

source <(grep = ${PROJECT_ROOT}/.stak-config | sed 's/ *= */=/g' | sed 's/\./_/g')

if [ -z "$FWUP" ]; then
	echo "fwup not configured for this image. Continuing without update support."
	if [ -z "$KPARTX" ]; then
		echo "kpartx not found on this system."
		echo "please install to continue"
		exit 1
	fi
	echo "Exiting..."
	exit 1

	mkdir -p ${BOOT_DIR} > /dev/null 2>&1
	mkdir -p ${ROOT_DIR} > /dev/null 2>&1

	sudo ${TAR} xvpsf output/images/rootfs.tar -C ${ROOT_DIR} > /dev/null > /dev/null 2>&1
	
	sudo ${CP} output/build/rpi-firmware-*/boot/bootcode.bin ${BOOT_DIR}/ > /dev/null > /dev/null 2>&1
	sudo ${CP} output/build/rpi-firmware-*/boot/start.elf ${BOOT_DIR}/ > /dev/null > /dev/null 2>&1
	sudo ${CP} output/build/rpi-firmware-*/boot/start_x.elf ${BOOT_DIR}/ > /dev/null > /dev/null 2>&1
	sudo ${CP} output/build/rpi-firmware-*/boot/fixup.dat ${BOOT_DIR}/ > /dev/null > /dev/null 2>&1
	
	sudo ${CP} ${STAK_SUPPORT}/cmdline.txt ${BOOT_DIR}/cmdline.txt > /dev/null > /dev/null 2>&1
	sudo ${CP} ${STAK_SUPPORT}/config.txt ${BOOT_DIR}/config.txt > /dev/null > /dev/null 2>&1
	sudo install -m 775 ${STAK_SUPPORT}/dt-blob.bin	${BOOT_DIR}/ > /dev/null > /dev/null 2>&1
	
	sudo ${CP} output/images/zImage ${BOOT_DIR}/kernel.img > /dev/null > /dev/null 2>&1
	
	ROOTSIZE_MB="256" # "$(( ( `sudo du -h -s -S --total ${ROOT_DIR}/ | tail -1 | cut -f 1 | sed s'/.$//'`) + 10))"
	
	BOOTSIZE=`sudo du -h -s -S --total ${BOOT_DIR}/ | tail -1 | cut -f 1 | sed s'/.$//' | awk '{printf("%d\n",$1 + 0.5)}'`
	BOOTSIZE_MB="$(( ${BOOTSIZE} + 4 ))"
	
	RECOVERY_BOOTSIZE="10" #`sudo du -h -s -S --total ${RECOVERY_BOOT_DIR}/ | tail -1 | cut -f 1 | sed s'/.$//' | awk '{printf("%d\n",$1 + 0.5)}'`
	
	TOTAL_SIZE="$(( ${ROOTSIZE_MB} + ${BOOTSIZE_MB} + ${RECOVERY_BOOTSIZE} + 14))"

	echo "Boot Size: ${BOOTSIZE_MB}"
	echo "Recovery boot: ${RECOVERY_BOOTSIZE}"
	echo "Root Size: ${ROOTSIZE_MB}"
	echo "Total Size: ${TOTAL_SIZE}"
	if [ -d ${IMAGE} ]; then
		rm ${IMAGE} > /dev/null 2>&1
	fi

	if [ -d ${IMAGE}.bz2 ]; then
		rm -f ${IMAGE}.bz2 > /dev/null 2>&1
	fi

	${DD} if=/dev/zero of=${IMAGE} bs=1MiB count=${TOTAL_SIZE} > /dev/null 2>&1

	# partition image
	${FDISK} ${IMAGE} > /dev/null 2>&1 <<-END
		o
		n
		p
		1
		
		+${BOOTSIZE_MB}M
		
		n
		p
		2
		
		+${RECOVERY_BOOTSIZE}M
		
		n
		p
		3
		
		+$(( $ROOTSIZE_MB + 10 ))M
		
		t
		1
		e
		t
		2
		e
		a
		1
		w
	END

	KPARTX_OUTPUT=sudo ${KPARTX} -al ${IMAGE}
	BOOTLOOP=/dev/mapper/`echo "${KPARTX_OUTPUT}" | awk 'NR==1 {print $1}'`
	ROOTLOOP=/dev/mapper/`echo "${KPARTX_OUTPUT}" | awk 'NR==3 {print $1}'`
	sudo ${KPARTX} -a ${IMAGE}

	echo "Boot loop: ${BOOTLOOP}"
	echo "Root loop: ${ROOTLOOP}"
	
	if [ -d 'sdimage' ]; then
		sudo rm -Rf sdimage
	fi
	
	mkdir sdimage
	mkdir -p sdimage/root
	mkdir -p sdimage/boot
	
	sudo ${MKFS_VFAT} -F16 -n BOOT -S 512 ${BOOTLOOP} > /dev/null 2>&1
	sudo ${MKFS_EXT4} -T small ${ROOTLOOP} > /dev/null 2>&1

	sudo ${MOUNT} -t vfat -w ${BOOTLOOP} sdimage/boot
	sudo ${MOUNT} -t ext4 -w ${ROOTLOOP} sdimage/root
	
	sudo ${CP} -rf ${BOOT_DIR}/* sdimage/boot
	sudo ${CP} -rf ${ROOT_DIR}/* sdimage/root
	
	CHECKSUM=`sha256sum output/images/rootfs.ext2 | awk 'NR==1 {print $1}'`
	
	if [ -f sdimage/root/sbin/init ];
	then
		echo "Init exists."
	else
		echo "Init does not exist!"
	fi

	sync && sync > /dev/null 2>&1

	df -h
	
	sudo ${UMOUNT} sdimage/boot
	sudo ${UMOUNT} sdimage/root
	
	sudo ${KPARTX} -d ${IMAGE} > /dev/null 2>&1
	sudo rm -Rf sdimage/

else
	export SECS=$(cat <${TARGETDIR}/../target/stak/version )
	echo "***** SECS=${SECS} TARGETDIR=${TARGETDIR}"
	DATE=`date -d @${SECS} '+%Y-%m-%d-%s'`

	echo "fwup configured for this image. Continuing with update support."
	# Build the firmware image (.fw file)
	echo "Creating firmware file..."
	FW_VERSION=${DATE} PROJECT_ROOT=${PROJECT_ROOT} ${FWUP} -c -f ${FWUP_CONFIG} -o ${FW_PATH}

	echo "Uploading to S3..."

	BUILDNUMBER=`git rev-list --count --first-parent HEAD`
	# UPLOADNAME=stak-nightly-`date '+%Y-%m-%d-%s'`-r$BUILDNUMBER.img


	build_type="debug"
	S3_OPTIONS="put --acl-public --no-guess-mime-type --disable-multipart"
	S3_BUCKET="stak-images"
	S3_URL="s3://${S3_BUCKET}"
	
	HTTP_URL="http://${S3_BUCKET}.s3.amazonaws.com"

	function fw_upload_full {
		# Build a raw image that can be directly written to
		# an SDCard (remove an exiting file so that the file that
		# is written is of minimum size. Otherwise, fwup just modifies
		# the file. It will work, but may be larger than necessary.)
		echo "Creating raw SDCard image file..."
		rm -f ${IMG_PATH}

		$FWUP -a -d ${IMG_PATH} -i ${FW_PATH} -t complete


		FW_FULL_NAME="stak-fw-full-${DATE}-r${BUILDNUMBER}.img"
		if [ $build_type == "release" ]; then
			FW_FULL_PATH="firmware/otto/full"
		else
			FW_FULL_PATH="firmware/otto/full-unstable"
		fi
		FW_FULL_CHECKSUM=`md5sum ${IMG_PATH} | awk 'NR==1 {print $1}'`
		FW_FULL_FILESIZE=`stat -c "%s" ${IMG_PATH}`


		cat > output/images/latest-full <<-EOF
		{
		"update_available": true,
		"url": "${HTTP_URL}/${FW_FULL_PATH}/${FW_FULL_NAME}",
		"size": ${FW_FULL_FILESIZE},
		"checksum": "${FW_FULL_CHECKSUM}",
		"new_version": ${SECS}
		}
		EOF

		#${S3CMD} ${S3_OPTIONS} ${IMG_PATH} ${S3_URL}/${FW_FULL_PATH}/${FW_FULL_NAME}
		#${S3CMD} ${S3_OPTIONS} output/images/latest-full ${S3_URL}/${FW_FULL_PATH}/latest

		#echo "Uploaded full firmware image to ${HTTP_URL}/${FW_FULL_PATH}/${FW_FULL_NAME}"
		echo "Complete!"
	}

	function fw_upload_update {
		FW_UPDATE_NAME="stak-fw-update-${DATE}-r${BUILDNUMBER}.zip"
		if [ $build_type == "release" ]; then
			FW_UPDATE_PATH="firmware/otto/update"
		else
			FW_UPDATE_PATH="firmware/otto/update-unstable"
		fi
		FW_UPDATE_CHECKSUM=`md5sum ${FW_PATH} | awk 'NR==1 {print $1}'`
		FW_UPDATE_FILESIZE=`stat -c "%s" ${FW_PATH}`


		cat > output/images/latest-update <<-EOF
			{
				"update_available": true,
				"url": "${HTTP_URL}/${FW_UPDATE_PATH}/${FW_UPDATE_NAME}",
				"size": ${FW_UPDATE_FILESIZE},
				"checksum": "${FW_UPDATE_CHECKSUM}",
				"new_version": ${SECS}
			}
		EOF

		#${S3CMD} ${S3_OPTIONS} ${FW_PATH} ${S3_URL}/${FW_UPDATE_PATH}/${FW_UPDATE_NAME}
		#${S3CMD} ${S3_OPTIONS} output/images/latest-update ${S3_URL}/${FW_UPDATE_PATH}/latest

		#echo "Uploaded firmware update to ${HTTP_URL}/${FW_UPDATE_PATH}/${FW_UPDATE_NAME}"
		echo "Complete!"
	}

	fw_upload_full
	fw_upload_update

	exit 0
	echo "Preparing build of type '${build_type}'"
	echo "Please select a firmware type to upload:"
	select num in "None" "Full" "Update" "Both"; do
		case $num in
			None )
				break
			;;

			# create full firmware image
			Full )
				fw_upload_full
				break
			;;

			# create firmware update image
			Update )
				fw_upload_update
				break
			;;

			# create both firmware images
			Both )
				fw_upload_full
				fw_upload_update
				break
			;;
		esac
	done
	exit 0
fi
