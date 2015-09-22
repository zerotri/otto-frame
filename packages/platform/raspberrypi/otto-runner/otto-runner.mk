#############################################################
#
# otto-runner
#
#############################################################

OTTO_RUNNER_VERSION = master
OTTO_RUNNER_SITE = $(call github,NextThingCo,otto-runner,$(OTTO_RUNNER_VERSION))

OTTO_RUNNER_LICENSE = GPLv2
OTTO_RUNNER_LICENSE_FILES = LICENCE
OTTO_RUNNER_CONF_OPTS =-DCMAKE_BUILD_TYPE=Debug -DVC_SDK=$(STAGING_DIR)/opt/vc

define OTTO_RUNNER_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/otto-runner $(TARGET_DIR)/usr/bin
endef

$(eval $(cmake-package))
