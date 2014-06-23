# Common UltimaAOSP overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/ultimaaosp/overlay/common

# Common product property overrides
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.android.dateformat=dd-MM-yyy \

# Include UltimaAOSP boot animation
ifneq ($(BOOTANIMATION_NAME),)
PRODUCT_COPY_FILES += \
    vendor/ultimaaosp/prebuilt/common/bootanimation/$(BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
else
PRODUCT_COPY_FILES += \
    vendor/ultimaaosp/prebuilt/common/bootanimation/BOOTANIMATION-800x480.zip:system/media/bootanimation.zip
endif

# Mount/unmount system support
PRODUCT_COPY_FILES += \
    vendor/ultimaaosp/prebuilt/common/bin/sysrw:system/bin/sysrw \
    vendor/ultimaaosp/prebuilt/common/bin/sysro:system/bin/sysro


# Required UltimaAOSP Packages
PRODUCT_PACKAGES += \
    Apollo \
    Torch \
    UltimaControl \
    UltimaWallpapers 

# Live wallpapers
PRODUCT_PACKAGES += \
    SunBeam

# Inherit common product build prop overrides
-include vendor/ultimaaosp/configs/common_versions.mk
