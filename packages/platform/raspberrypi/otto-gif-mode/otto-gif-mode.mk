#############################################################
#
# otto-gif-mode
#
#############################################################

OTTO_GIF_MODE_VERSION = master  
OTTO_GIF_MODE_SITE = $(call github,NextThingCo,otto-gif-mode,$(OTTO_GIF_MODE_VERSION))
OTTO_GIF_MODE_LICENSE = GPLv2
OTTO_GIF_MODE_LICENSE_FILES = LICENCE
OTTO_GIF_MODE_INSTALL_STAGING = NO
OTTO_GIF_MODE_INSTALL_TARGET = YES
OTTO_GIF_MODE_CONF_OPTS = -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -march=armv6 -mfloat-abi=hard" -DVC_SDK="$(STAGING_DIR)/opt/vc"

define OTTO_GIF_MODE_GIT_SUBMODULE_FIXUP
	# git -C $(@D) submodule update --init --recursive
	git clone http://github.com/sansumbrella/Choreograph.git $(@D)/deps/Choreograph
	git clone http://github.com/alecthomas/entityx.git $(@D)/deps/entityx
	git clone http://github.com/NextThingCo/otto-runner.git $(@D)/deps/otto-runner
	git clone http://github.com/NextThingCo/otto-utils.git $(@D)/deps/otto-utils
endef

define OTTO_GIF_MODE_INSTALL_TARGET_CMDS
  $(INSTALL) -d 0644 $(TARGET_DIR)/stak/sdk
  $(INSTALL) -d 0644 $(TARGET_DIR)/stak/sdk/assets
  $(INSTALL) -m 0755 $(@D)/libotto_gif_mode.so $(TARGET_DIR)/stak/sdk
  $(INSTALL) -m 0755 $(@D)/assets/* $(TARGET_DIR)/stak/sdk/assets
endef

OTTO_GIF_MODE_POST_DOWNLOAD_HOOKS += OTTO_GIF_MODE_GIT_SUBMODULE_FIXUP


$(eval $(cmake-package))
