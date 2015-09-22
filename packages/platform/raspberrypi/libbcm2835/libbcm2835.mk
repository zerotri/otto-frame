#############################################################
#
# libbcm2835
#
#############################################################

LIBBCM2835_VERSION = 1.42
LIBBCM2835_SITE = http://www.airspayce.com/mikem/bcm2835/
LIBBCM2835_SOURCE = bcm2835-$(LIBBCM2835_VERSION).tar.gz
LIBBCM2835_LICENSE = GPLv2
LIBBCM2835_LICENSE_FILES = LICENCE
LIBBCM2835_INSTALL_STAGING = YES
LIBBCM2835_CONF_OPTS = CFLAGS="$(TARGET_CFLAGS) -march=armv6 -mfloat-abi=hard"

#	define LIBBCM2835_INSTALL_STAGING_CMDS
#		echo "Hello World"
#		$(INSTALL) -D -m 0755 $(@D)/src/libbcm2835.a $(STAGING_DIR)/usr/lib/libbcm2835.a
#		$(INSTALL) -D -m 0644 $(@D)/src/bcm2835.h $(STAGING_DIR)/usr/include/bcm2835.h
#	endef


$(eval $(autotools-package))