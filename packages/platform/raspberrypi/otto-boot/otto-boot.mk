#############################################################
#
# otto-boot
#
#############################################################

OTTO_BOOT_VERSION = 0.1
OTTO_BOOT_SITE = $(BASE_DIR)/../package/stak/platform/raspberrypi/otto-boot/files
OTTO_BOOT_SITE_METHOD = local
OTTO_BOOT_LICENSE = GPLv2
OTTO_BOOT_LICENSE_FILES = LICENCE

define OTTO_BOOT_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(@D)/otto-boot.service \
		$(TARGET_DIR)/usr/lib/systemd/system/otto-boot.service
	$(INSTALL) -D -m 644 $(@D)/otto-bq27510.service \
		$(TARGET_DIR)/usr/lib/systemd/system/otto-bq27510.service
	$(INSTALL) -D -m 644 $(@D)/otto-bq27510-shutdown.service \
		$(TARGET_DIR)/usr/lib/systemd/system/otto-bq27510-shutdown.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	mkdir -p $(TARGET_DIR)/etc/systemd/system/halt.target.wants
	ln -fs /usr/lib/systemd/system/otto-boot.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/otto-boot.service
	ln -fs /usr/lib/systemd/system/otto-bq27510.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/otto-bq27510.service
	ln -fs /usr/lib/systemd/system/otto-bq27510-shutdown.service \
		$(TARGET_DIR)/etc/systemd/system/halt.target.wants/otto-bq27510-shutdown.service
endef

$(eval $(generic-package))
