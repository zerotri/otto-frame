#############################################################
#
# otto-update
#
#############################################################

OTTOUPDATE_VERSION = 9a3e6d86b3c3f143a4eb3b12a6b461e2649348df
OTTOUPDATE_SITE = git@github.com:NextThingCo/otto-update.git
OTTOUPDATE_SITE_METHOD = git
# OTTOUPDATE_SITE = file://$(TOPDIR)/package/stak/platform/raspberrypi/ottoupdate
# OTTOUPDATE_SOURCE = otto-update-$(OTTOUPDATE_VERSION).tar.gz
OTTOUPDATE_LICENSE = GPLv2
OTTOUPDATE_LICENSE_FILES = LICENCE


define OTTOUPDATE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/otto-update $(TARGET_DIR)/usr/bin/
endef
$(eval $(cmake-package))
