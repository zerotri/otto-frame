#############################################################
#
# otto-logo
#
#############################################################

OTTO_LOGO_VERSION = 50165918b3d7d3764451db0b3b13cead2435e686
OTTO_LOGO_SITE = git@github.com:NextThingCo/otto-logo.git
OTTO_LOGO_SITE_METHOD = git

OTTO_LOGO_LICENSE = GPLv2
OTTO_LOGO_LICENSE_FILES = LICENCE

# define OTTO_LOGO_INSTALL_TARGET_CMDS
#     $(INSTALL) -D -m 0755 $(@D)/otto-logo $(TARGET_DIR)/usr/bin
# endef

$(eval $(cmake-package))
