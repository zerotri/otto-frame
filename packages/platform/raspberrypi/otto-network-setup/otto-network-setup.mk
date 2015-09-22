#############################################################
#
# otto-network-setup
#
#############################################################

OTTO_NETWORK_SETUP_VERSION = master
OTTO_NETWORK_SETUP_SITE = $(call github,NextThingCo,otto-network-setup,$(OTTO_NETWORK_SETUP_VERSION))
OTTO_NETWORK_SETUP_INSTALL_TARGET = YES
OTTO_NETWORK_SETUP_LICENSE = MIT
OTTO_NETWORK_SETUP_LICENSE_FILES = LICENSE

define OTTO_NETWORK_SETUP_INSTALL_INIT_SYSTEMD

	$(INSTALL) -D -m 755 $(@D)/otto-network-setup.py \
		$(TARGET_DIR)/usr/bin/otto-network-setup.py

	$(INSTALL) -D -m 644 $(@D)/views/setup.tpl \
		$(TARGET_DIR)/usr/lib/otto-network-setup/views/setup.tpl

	$(INSTALL) -D -m 644 $(@D)/views/images.tpl \
		$(TARGET_DIR)/usr/lib/otto-network-setup/views/images.tpl

	$(INSTALL) -D -m 644 $(@D)/assets/jquery-1.11.2.min.js \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/jquery-1.11.2.min.js

	$(INSTALL) -D -m 644 $(@D)/assets/bootstrap/js/bootstrap.js \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/bootstrap/js/bootstrap.min.js

	$(INSTALL) -D -m 644 $(@D)/assets/bootstrap/css/bootstrap.min.css \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/bootstrap/css/bootstrap.min.css

	$(INSTALL) -D -m 644 $(@D)/assets/bootstrap/fonts/glyphicons-halflings-regular.woff2 \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/bootstrap/fonts/glyphicons-halflings-regular.woff2

	$(INSTALL) -D -m 644 $(@D)/assets/bootstrap/fonts/glyphicons-halflings-regular.svg \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/bootstrap/fonts/glyphicons-halflings-regular.svg

	$(INSTALL) -D -m 644 $(@D)/assets/bootstrap/fonts/glyphicons-halflings-regular.woff \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/bootstrap/fonts/glyphicons-halflings-regular.woff

	$(INSTALL) -D -m 644 $(@D)/assets/bootstrap/fonts/glyphicons-halflings-regular.ttf \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/bootstrap/fonts/glyphicons-halflings-regular.ttf

	$(INSTALL) -D -m 644 $(@D)/assets/bootstrap/fonts/glyphicons-halflings-regular.eot \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/bootstrap/fonts/glyphicons-halflings-regular.eot

	$(INSTALL) -D -m 644 $(@D)/assets/PhotoSwipe/photoswipe-ui-default.min.js \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/PhotoSwipe/photoswipe-ui-default.min.js

	$(INSTALL) -D -m 644 $(@D)/assets/PhotoSwipe/photoswipe.min.js \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/PhotoSwipe/photoswipe.min.js

	$(INSTALL) -D -m 644 $(@D)/assets/PhotoSwipe/photoswipe.js \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/PhotoSwipe/photoswipe.js

	$(INSTALL) -D -m 644 $(@D)/assets/PhotoSwipe/photoswipe.css \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/PhotoSwipe/photoswipe.css

	$(INSTALL) -D -m 644 $(@D)/assets/PhotoSwipe/photoswipe-ui-default.js \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/PhotoSwipe/photoswipe-ui-default.js

	$(INSTALL) -D -m 644 $(@D)/assets/PhotoSwipe/default-skin/default-skin.css \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/PhotoSwipe/default-skin/default-skin.css

	$(INSTALL) -D -m 644 $(@D)/assets/PhotoSwipe/default-skin/default-skin.svg \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/PhotoSwipe/default-skin/default-skin.svg

	$(INSTALL) -D -m 644 $(@D)/assets/PhotoSwipe/default-skin/default-skin.png \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/PhotoSwipe/default-skin/default-skin.png

	$(INSTALL) -D -m 644 $(@D)/assets/PhotoSwipe/default-skin/preloader.gif \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/PhotoSwipe/default-skin/preloader.gif

	$(INSTALL) -D -m 644 $(@D)/assets/otto-logo-white.svg \
		$(TARGET_DIR)/usr/lib/otto-network-setup/assets/otto-logo-white.svg

	$(INSTALL) -D -m 644 $(@D)/otto-network-setup.service \
		$(TARGET_DIR)/usr/lib/systemd/system/otto-network-setup.service

	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	#ln -fs ../../../../usr/lib/systemd/system/otto-network-setup.service \
	#	$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/otto-network-setup.service

endef

$(eval $(generic-package))
