# Common UltimaAOSP overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/ultimamod/overlay/common

# Mount/unmount system support
PRODUCT_COPY_FILES += \
    vendor/ultimamod/prebuilt/common/bin/sysrw:system/bin/sysrw \
    vendor/ultimamod/prebuilt/common/bin/sysro:system/bin/sysro

# Required UltimaAOSP Packages
PRODUCT_PACKAGES += \
    UltimaWallpapers 

# Live wallpapers
PRODUCT_PACKAGES += \
    SunBeam

