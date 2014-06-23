# Device Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/ultimaaosp/overlay/i9300

# Define boot animation size
BOOTANIMATION_NAME := BOOTANIMATION-1280x720

# Inherit AOSP device configuration.
$(call inherit-product, device/samsung/i9300/full_i9300.mk)

# Inherit common product files.
$(call inherit-product, vendor/ultimaaosp/configs/common.mk)

# Inherit GSM files.
$(call inherit-product, vendor/ultimaaosp/configs/common_phone.mk)

# Setup device specific product configuration.
PRODUCT_NAME := i9300
PRODUCT_BRAND := samsung
PRODUCT_DEVICE := i9300
PRODUCT_MODEL := GT-I9300
PRODUCT_MANUFACTURER := samsung

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=m0xx TARGET_DEVICE=m0 BUILD_FINGERPRINT="samsung/m0xx/m0:4.3/JSS15J/I9300XXUGMJ9:user/release-keys" PRIVATE_BUILD_DESC="m0xx-user 4.3 JSS15J I9300XXUGMJ9 release-keys"
