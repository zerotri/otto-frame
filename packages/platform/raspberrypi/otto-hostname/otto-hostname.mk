#############################################################
#
# otto-hostname
#
#############################################################

OTTO_HOSTNAME_VERSION = 0.1
OTTO_HOSTNAME_SITE = $(BASE_DIR)/../package/stak/platform/raspberrypi/otto-hostname/files
OTTO_HOSTNAME_SITE_METHOD = local
OTTO_HOSTNAME_LICENSE = GPLv2
OTTO_HOSTNAME_LICENSE_FILES = LICENCE

define OTTO_HOSTNAME_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(@D)/otto-hostname.service \
		$(TARGET_DIR)/usr/lib/systemd/system/otto-hostname.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	ln -fs ../../../../usr/lib/systemd/system/otto-hostname.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/otto-hostname.service
endef

$(eval $(generic-package))
