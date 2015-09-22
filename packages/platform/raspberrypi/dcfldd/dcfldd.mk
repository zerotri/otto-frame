#############################################################
#
# dcfldd
#
#############################################################

DCFLDD_VERSION = 1.3.4-1
DCFLDD_SITE = http://downloads.sourceforge.net/project/dcfldd/dcfldd/$(DCFLDD_VERSION)/
DCFLDD_SOURCE = dcfldd-$(DCFLDD_VERSION).tar.gz
DCFLDD_LICENSE = GPLv2
DCFLDD_LICENSE_FILES = LICENCE


define DCFLDD_BUILD_CMDS
    cd $(@D) && ./configure --prefix=$(TARGET_DIR)/usr/
    $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) all
endef

define DCFLDD_INSTALL_TARGET_CMDS
    $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
