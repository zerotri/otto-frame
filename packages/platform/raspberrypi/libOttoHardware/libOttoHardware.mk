#############################################################
#
# libOttoHardware
#
#############################################################

LIBOTTOHARDWARE_VERSION = master
LIBOTTOHARDWARE_SITE = $(call github,NextThingCo,libOttoHardware,$(LIBOTTOHARDWARE_VERSION))

LIBOTTOHARDWARE_LICENSE = GPLv2
LIBOTTOHARDWARE_LICENSE_FILES = LICENCE
LIBOTTOHARDWARE_CONF_OPTS = -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -march=armv6 -mfloat-abi=hard"
LIBOTTOHARDWARE_INSTALL_STAGING = YES
LIBOTTOHARDWARE_INSTALL_TARGET = YES


$(eval $(cmake-package))
