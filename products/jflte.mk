# Device Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/ultimaaosp/overlay/jflte

# Define boot animation size
BOOTANIMATION_NAME := BOOTANIMATION-1920x1080

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from jfltetmo device
$(call inherit-product, device/samsung/jflte/device.mk)

# Inherit AOSP device configuration.
$(call inherit-product, device/samsung/jflte/full_jflte.mk)

# Inherit common product files.
$(call inherit-product, vendor/ultimaaosp/configs/common.mk)

# Inherit GSM files.
$(call inherit-product, vendor/ultimaaosp/configs/common_phone.mk)

# Setup device specific product configuration.
PRODUCT_NAME := jflte
PRODUCT_BRAND := samsung
PRODUCT_DEVICE := jflte
PRODUCT_MODEL := GT-I9505
PRODUCT_MANUFACTURER := samsung

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=jflte TARGET_DEVICE=jflte BUILD_FINGERPRINT="samsung/jflte/jflte:4.2.2/JDQ39/I9505XXUAMDE:user/release-keys" PRIVATE_BUILD_DESC="jflte-user 4.2.2 JDQ39 I9505XXUAMDE release-keys"
