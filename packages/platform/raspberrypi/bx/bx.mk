#############################################################
#
# bx
#
#############################################################

BX_VERSION = cea35437ca
BX_SITE = $(call github,NextThingCo,bx,$(BX_VERSION))
BX_LICENSE = GPLv2
BX_LICENSE_FILES = LICENCE
BX_INSTALL_STAGING = YES


define BX_BUILD_CMDS
    $(MAKE) GENIE="GENIE=../bx-$(BX_VERSION)/tools/bin/linux/genie" CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) rpi
endef

define BX_INSTALL_STAGING_CMDS
    # $(INSTALL) -D -m 0755 $(@D)/libarmmem.a $(STAGING_DIR)/usr/lib/libarmmem.a
endef

define BX_INSTALL_TARGET_CMDS
    # $(INSTALL) -D -m 0755 $(@D)/libarmmem.a $(TARGET_DIR)/usr/lib
endef

$(eval $(generic-package))