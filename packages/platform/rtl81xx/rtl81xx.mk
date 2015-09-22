#############################################################
#
# rtl81xx
#
#############################################################

RTL81XX_VERSION = ubuntu-14.04
RTL81XX_SITE = $(call github,FreedomBen,rtl8188ce-linux-driver,$(RTL81XX_VERSION))
RTL81XX_LICENSE = GPLv2
RTL81XX_LICENSE_FILES = LICENCE
RTL81XX_INSTALL_STAGING = YES


define RTL81XX_BUILD_CMDS
	# cd $(@D) ; premake4 gmake
	git checkout ubuntu-14.04
	make CROSS_COMPILE="$(TARGET_CROSS)" ARCH=arm KSRC=$(LINUX_DIR) -C $(@D)

	#make CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)/build config=release nanovg
endef

define RTL81XX_INSTALL_STAGING_CMDS
	# $(INSTALL) -D -m 0755 $(@D)/build/libnanovg.a $(STAGING_DIR)/usr/lib/libnanovg.a
	# $(INSTALL) -D -m 0755 $(@D)/src/nanovg.h $(STAGING_DIR)/usr/include/nanovg.h
    # $(INSTALL) -D -m 0755 $(@D)/libarmmem.a $(STAGING_DIR)/usr/lib/libarmmem.a
endef

define RTL81XX_INSTALL_TARGET_CMDS
    # $(INSTALL) -D -m 0755 $(@D)/libarmmem.a $(TARGET_DIR)/usr/lib
endef

$(eval $(generic-package))