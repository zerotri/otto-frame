#############################################################
#
# armmem
#
#############################################################

ARMMEM_VERSION = 2e6f275a327dd30ce55704ca013bab493ec54190
ARMMEM_SITE = git://github.com/bavison/arm-mem.git
ARMMEM_LICENSE = GPLv2
ARMMEM_LICENSE_FILES = LICENCE


define ARMMEM_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) all
endef

define ARMMEM_INSTALL_STAGING_CMDS
    $(INSTALL) -D -m 0755 $(@D)/libarmmem.a $(STAGING_DIR)/usr/lib/libarmmem.a
endef

define ARMMEM_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/libarmmem.a $(TARGET_DIR)/usr/lib
endef

$(eval $(generic-package))