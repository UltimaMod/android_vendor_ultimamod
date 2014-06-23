# Version information used on all builds
PRODUCT_BUILD_PROP_OVERRIDES += \
	BUILD_DISPLAY_ID=$(ULTIMA_BUILD) \
	BUILD_ID=$(ULTIMA_BUILD) \
	BUILD_UTC_DATE=0

# UltimaAOSP branding
# Now exported via the build script
ULTIMAAOSP_ROMNAME = UltimaAOSP
ULTIMAAOSP_BUILD_VERSION = Valhalla
ULTIMAAOSP_VERSION_MAJOR = 2
ULTIMAAOSP_VERSION_MINOR = 0
ULTIMAAOSP_UPDATE_URL = http://www.ultimarom.com/rom/update/update_manifest.xml

PRODUCT_PROPERTY_OVERRIDES += \
    ro.ua.romname=$(ULTIMAAOSP_ROMNAME) \
    ro.ua.version=v$(ULTIMAAOSP_VERSION_MAJOR).$(ULTIMAAOSP_VERSION_MINOR) \
    ro.ua.codename=$(ULTIMAAOSP_BUILD_VERSION) \
    ro.ua.version.stats=UltimaAOSP-$(ULTIMAAOSP_BUILD_VERSION)-v$(ULTIMAAOSP_VERSION_MAJOR).$(ULTIMAAOSP_VERSION_MINOR) \
    ro.ua.device=$(TARGET_PRODUCT)

# OTA Values
PRODUCT_PROPERTY_OVERRIDES += \
    ro.ota.romname=$(ULTIMAAOSP_ROMNAME) \
    ro.ota.version=$(ULTIMAAOSP_VERSION_MAJOR).$(ULTIMAAOSP_VERSION_MINOR) \
    ro.ota.codename=$(ULTIMAAOSP_BUILD_VERSION) \
    ro.ota.device=$(TARGET_PRODUCT) \
    ro.ota.manifest= $(ULTIMAAOSP_UPDATE_URL) \

