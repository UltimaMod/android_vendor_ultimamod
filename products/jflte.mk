# Device Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/ultimaaosp/overlay/jflte

# Define boot animation size
BOOTANIMATION_NAME := BOOTANIMATION-1920x1080

# Inherit AOSP device configuration.
$(call inherit-product, device/samsung/jflte/cm.mk)

# Inherit common product files.
$(call inherit-product, vendor/ultimaaosp/configs/common.mk)

# Inherit GSM files.
$(call inherit-product, vendor/ultimaaosp/configs/common_phone.mk)
