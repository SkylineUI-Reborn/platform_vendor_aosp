# Build Date
CUSTOM_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)

# Type of Build
CUSTOM_BUILD_TYPE ?= UNOFFICIAL

# Platform (Android Version)
CUSTOM_PLATFORM_VERSION := 15

SKYLINEUI_BUILD_VERSION := Power
CUSTOM_VERSION := SkylineUI-$(SKYLINEUI_BUILD_VERSION)-$(CUSTOM_PLATFORM_VERSION)-$(CUSTOM_BUILD)-$(CUSTOM_BUILD_DATE)-$(CUSTOM_BUILD_TYPE)
CUSTOM_VERSION_PROP := fifteen

# SkylineUI Platform Version
PRODUCT_PRODUCT_PROPERTIES += \
    ro.custom.build.date=$(BUILD_DATE) \
    ro.custom.device=$(CUSTOM_BUILD) \
    ro.custom.fingerprint=$(ROM_FINGERPRINT) \
    ro.custom.version=$(CUSTOM_VERSION) \
    ro.modversion=$(CUSTOM_VERSION) \
    org.skylineui.build_version=$(SKYLINEUI_BUILD_VERSION) \
    org.skylineui.build_type=$(CUSTOM_BUILD_TYPE) \
    org.skylineui.version.display=$(CUSTOM_VERSION) \
    ro.skylineui.maintainer=$(SKYLINEUI_MAINTAINER)

# Signing
ifneq (eng,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard vendor/aosp/signing/keys/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/aosp/signing/keys/releasekey
ifneq ($(TARGET_NO_OEM_UNLOCK),true)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
endif
ifneq (,$(wildcard vendor/aosp/signing/keys/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := vendor/aosp/signing/keys/otakey.x509.pem
endif
endif
