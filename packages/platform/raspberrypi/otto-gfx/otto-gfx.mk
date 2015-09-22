#############################################################
#
# otto-gfx
#
#############################################################

OTTO_GFX_VERSION = master
OTTO_GFX_SITE = $(call github,NextThingCo,otto-gfx,$(OTTO_GFX_VERSION))
OTTO_GFX_LICENSE = GPLv2
OTTO_GFX_LICENSE_FILES = LICENCE
OTTO_GFX_CONF_OPTS = -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -march=armv6 -mfloat-abi=hard" -DVC_SDK=$(STAGING_DIR)/opt/vc
OTTO_GFX_INSTALL_STAGING = YES
OTTO_GFX_INSTALL_TARGET = YES

define OTTO_GFX_GIT_SUBMODULE_FIXUP
  # git -C $(@D) submodule update --init --recursive
endef

# define OTTO_GFX_INSTALL_STAGING_CMDS
#         $(INSTALL) -m 0644 $(@D)/libotto_gfx.so $(STAGING_DIR)/usr/lib
#         $(INSTALL) -m 0644 $(@D)/src/*.hpp $(STAGING_DIR)/usr/include
#         cp -rf $(@D)/deps/glm/glm/* $(STAGING_DIR)/usr/include
#         cp -rf $(@D)/deps/nanosvg/src/* $(STAGING_DIR)/usr/include
# endef

# define OTTO_GFX_INSTALL_TARGET_CMDS
#         $(INSTALL) -m 0644 $(@D)/libotto_gfx.so $(TARGET_DIR)/usr/lib
# endef

OTTO_GFX_POST_DOWNLOAD_HOOKS += OTTO_GFX_GIT_SUBMODULE_FIXUP


$(eval $(cmake-package))
