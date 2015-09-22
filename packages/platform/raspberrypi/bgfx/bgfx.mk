#############################################################
#
# bgfx
#
#############################################################

BGFX_VERSION = d45e245039
BGFX_SITE = $(call github,NextThingCo,bgfx,$(BGFX_VERSION))
BGFX_LICENSE = GPLv2
BGFX_LICENSE_FILES = LICENCE
BGFX_INSTALL_STAGING = YES


define BGFX_BUILD_CMDS
    $(MAKE) GENIE="GENIE=../bx-$(BX_VERSION)/tools/bin/linux/genie" CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) rpi-release
endef

define BGFX_INSTALL_STAGING_CMDS
    # $(INSTALL) -D -m 0755 $(@D)/libarmmem.a $(STAGING_DIR)/usr/lib/libarmmem.a
endef

define BGFX_INSTALL_TARGET_CMDS
    # $(INSTALL) -D -m 0755 $(@D)/libarmmem.a $(TARGET_DIR)/usr/lib
endef

$(eval $(generic-package))