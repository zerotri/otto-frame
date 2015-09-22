#############################################################
#
# libfoo
#
#############################################################
OTTDATE_VERSION = master
OTTDATE_SITE = $(call github,NextThingCo,OttDate,$(OTTDATE_VERSION))
OTTDATE_INSTALL_STAGING = YES
OTTDATE_INSTALL_TARGET = YES
OTTDATE_DEPENDENCIES = host-openssl openssl

$(eval $(cmake-package))
