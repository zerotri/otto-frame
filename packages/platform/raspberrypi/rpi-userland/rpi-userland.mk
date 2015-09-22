#############################################################
#
# stak-rpi-userland
#
#############################################################
STAK_RPI_USERLAND_VERSION = 8f542a1647e6f88f254eadd9ad6929301c81913b
STAK_RPI_USERLAND_SITE = $(call github,raspberrypi,userland,$(STAK_RPI_USERLAND_VERSION))
STAK_RPI_USERLAND_SOURCE = rpi-userland-$(STAK_RPI_USERLAND_VERSION).tar.gz
STAK_RPI_USERLAND_INSTALL_STAGING = YES
STAK_RPI_USERLAND_INSTALL_TARGET = YES
STAK_RPI_USERLAND_CONF_OPTS = -DVMCS_INSTALL_PREFIX=/usr \
  -DCMAKE_C_FLAGS="-DVCFILED_LOCKFILE=\\\"/var/run/vcfiled.pid\\\""

define STAK_RPI_USERLAND_INSTALL_TARGET_CMDS
        $(INSTALL) -m 0644 $(@D)/build/lib/*.so $(TARGET_DIR)/usr/lib
        $(INSTALL) -m 0755 $(@D)/build/bin/* $(TARGET_DIR)/usr/bin
endef

$(eval $(cmake-package))
