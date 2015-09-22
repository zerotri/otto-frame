#############################################################
#
# otto-fastcamd
#
#############################################################

OTTO_FASTCAMD_VERSION = 0.1
OTTO_FASTCAMD_SITE = $(BASE_DIR)/../package/stak/platform/raspberrypi/otto-fastcamd/files
OTTO_FASTCAMD_SITE_METHOD = local
OTTO_FASTCAMD_LICENSE = GPLv2
OTTO_FASTCAMD_LICENSE_FILES = LICENCE

define OTTO_FASTCAMD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/raspifastcamd $(TARGET_DIR)/usr/bin
endef

define OTTO_FASTCAMD_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(@D)/otto-fastcamd.service \
		$(TARGET_DIR)/usr/lib/systemd/system/otto-fastcamd.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	ln -fs ../../../../usr/lib/systemd/system/otto-fastcamd.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/otto-fastcamd.service
endef

$(eval $(generic-package))
