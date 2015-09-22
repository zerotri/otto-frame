#############################################################
#
# otto-wifi
#
#############################################################

OTTO_WIFI_VERSION = 0.1
OTTO_WIFI_SITE = $(BASE_DIR)/../package/stak/platform/raspberrypi/otto-wifi/files
OTTO_WIFI_SITE_METHOD = local
OTTO_WIFI_LICENSE = GPLv2
OTTO_WIFI_LICENSE_FILES = LICENCE

define OTTO_WIFI_INSTALL_INIT_SYSTEMD

	$(INSTALL) -D -m 644 $(@D)/otto-wifi.service \
		$(TARGET_DIR)/usr/lib/systemd/system/otto-wifi.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	#ln -fs ../../../../usr/lib/systemd/system/otto-wifi.service \
	#	$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/otto-wifi.service

  $(INSTALL) -D -m 644 $(@D)/dnsmasq.service \
    $(TARGET_DIR)/usr/lib/systemd/system/dnsmasq.service
  mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
  ln -fs ../../../../usr/lib/systemd/system/dnsmasq.service \
    $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/dnsmasq.service

  $(INSTALL) -D -m 644 $(@D)/hostapd.conf $(TARGET_DIR)/etc/hostapd.conf
  $(INSTALL) -D -m 644 $(@D)/dnsmasq.conf $(TARGET_DIR)/etc/dnsmasq.conf
  $(INSTALL) -D -m 644 $(@D)/main.conf $(TARGET_DIR)/etc/connman/main.conf

  sed -e "s/ExecStart=.*/ExecStart=\/usr\/sbin\/connmand -n --nodnsproxy/g" -i $(TARGET_DIR)/usr/lib/systemd/system/connman.service

endef

$(eval $(generic-package))
