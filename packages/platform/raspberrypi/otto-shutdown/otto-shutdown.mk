#############################################################
#
# otto-shutdown
#
#############################################################

OTTO_SHUTDOWN_VERSION = 0.1
OTTO_SHUTDOWN_SITE = $(BASE_DIR)/../package/stak/platform/raspberrypi/otto-shutdown/files
OTTO_SHUTDOWN_SITE_METHOD = local
OTTO_SHUTDOWN_LICENSE = GPLv2
OTTO_SHUTDOWN_LICENSE_FILES = LICENCE

define OTTO_SHUTDOWN_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(@D)/otto-shutdown.service \
		$(TARGET_DIR)/usr/lib/systemd/system/otto-shutdown.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/final.target.wants
	ln -fs ../../../../usr/lib/systemd/system/otto-shutdown.service \
		$(TARGET_DIR)/etc/systemd/system/final.target.wants/otto-shutdown.service
endef

$(eval $(generic-package))
