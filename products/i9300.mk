# Device Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/ultimamod/overlay/i9300

# Define boot animation size
BOOTANIMATION_NAME := BOOTANIMATION-1280x720

# Inherit AOSP device configuration.
$(call inherit-product, device/samsung/i9300/cm.mk)

# Inherit common product files.
$(call inherit-product, vendor/ultimamod/configs/common.mk)

# Inherit GSM files.
$(call inherit-product, vendor/ultimamod/configs/common_phone.mk)
