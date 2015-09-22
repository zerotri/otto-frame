ifeq ($(BR2_PACKAGE_LIBBCM2835),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/libbcm2835/libbcm2835.mk
endif

ifeq ($(BR2_PACKAGE_ARMMEM),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/armmem/armmem.mk
endif

ifeq ($(BR2_PACKAGE_GIFSICLE),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/gifsicle/gifsicle.mk
endif

ifeq ($(BR2_PACKAGE_BX),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/bx/bx.mk
endif

ifeq ($(BR2_PACKAGE_OTTO_FASTCAMD),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/otto-fastcamd/otto-fastcamd.mk
endif

ifeq ($(BR2_PACKAGE_LIBOTTOHARDWARE),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/libOttoHardware/libOttoHardware.mk
endif

ifeq ($(BR2_PACKAGE_NANOSVG),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/nanosvg/nanosvg.mk
endif

ifeq ($(BR2_PACKAGE_OTTOUPDATE),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/ottoupdate/ottoupdate.mk
endif

ifeq ($(BR2_PACKAGE_OTTO_RUNNER),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/otto-runner/otto-runner.mk
endif

ifeq ($(BR2_PACKAGE_OTTO_BOOT),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/otto-boot/otto-boot.mk
endif

ifeq ($(BR2_PACKAGE_OTTO_WIFI),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/otto-wifi/otto-wifi.mk
endif

ifeq ($(BR2_PACKAGE_OTTO_LOGO),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/otto-logo/otto-logo.mk
endif

ifeq ($(BR2_PACKAGE_OTTO_SHUTDOWN),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/otto-shutdown/otto-shutdown.mk
endif

ifeq ($(BR2_PACKAGE_OTTO_HOSTNAME),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/otto-hostname/otto-hostname.mk
endif

ifeq ($(BR2_PACKAGE_OTTO_GFX),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/otto-gfx/otto-gfx.mk
endif

ifeq ($(BR2_PACKAGE_OTTO_MENU),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/otto-menu/otto-menu.mk
endif

ifeq ($(BR2_PACKAGE_OTTO_NETWORK_SETUP),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/otto-network-setup/otto-network-setup.mk
endif

ifeq ($(BR2_PACKAGE_OTTO_GIF_MODE),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/otto-gif-mode/otto-gif-mode.mk
endif

ifeq ($(BR2_PACKAGE_DCFLDD),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/dcfldd/dcfldd.mk
endif

ifeq ($(BR2_PACKAGE_BGFX),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/bgfx/bgfx.mk
endif

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/rpi-userland/rpi-userland.mk
endif

ifeq ($(BR2_PACKAGE_OTTOSDK),y)
	include $(BR2_EXTERNAL)/packages/ottosdk/ottosdk.mk
endif

ifeq ($(BR2_PACKAGE_CREATE_AP),y)
	include $(BR2_EXTERNAL)/packages/platform/raspberrypi/create_ap/create_ap.mk
endif

ifeq ($(BR2_PACKAGE_RTL81XX),y)
	include $(BR2_EXTERNAL)/packages/platform/rtl81xx/rtl81xx.mk
endif

ifeq ($(BR2_PACKAGE_FWUP),y)
	include $(BR2_EXTERNAL)/packages/platform/generic/fwup/fwup.mk
endif

ifeq ($(BR2_PACKAGE_FWUP_HOST),y)
	include $(BR2_EXTERNAL)/packages/platform/generic/fwup/fwup.mk
endif

ifeq ($(BR2_PACKAGE_OTTDATE),y)
	include $(BR2_EXTERNAL)/packages/platform/generic/OttDate/OttDate.mk
endif
