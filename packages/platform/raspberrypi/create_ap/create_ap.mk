#############################################################
#
# create_ap
#
#############################################################

CREATE_AP_VERSION = 9dce88aee91254bc34cd4b942823a87684f971a7
CREATE_AP_SITE = $(call github,oblique,create_ap,$(CREATE_AP_VERSION))
CREATE_AP_LICENSE = GPLv2
CREATE_AP_LICENSE_FILES = LICENCE

define CREATE_AP_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/create_ap $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))