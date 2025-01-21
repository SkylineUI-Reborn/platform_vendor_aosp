# Date
CUSTOM_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)

# UTC Date
CUSTOM_DATE_YEAR := $(shell date -u +%Y)
CUSTOM_DATE_MONTH := $(shell date -u +%m)
CUSTOM_DATE_DAY := $(shell date -u +%d)
CUSTOM_DATE_HOUR := $(shell date -u +%H)
CUSTOM_DATE_MINUTE := $(shell date -u +%M)
CUSTOM_BUILD_DATE_UTC := $(shell date -d '$(CUSTOM_DATE_YEAR)-$(CUSTOM_DATE_MONTH)-$(CUSTOM_DATE_DAY) UTC' +%s)

# Type of Build
CUSTOM_BUILD_TYPE ?= UNOFFICIAL

# Platform (Android Version)
CUSTOM_PLATFORM_VERSION := 15-QPR1

SKYLINEUI_BUILD_VERSION := Veronica
CUSTOM_VERSION := SkylineUI-$(SKYLINEUI_BUILD_VERSION)-$(CUSTOM_PLATFORM_VERSION)-$(CUSTOM_BUILD)-$(CUSTOM_BUILD_DATE)-$(CUSTOM_BUILD_TYPE)
CUSTOM_VERSION_PROP := fifteen

# SkylineUI Platform Version
PRODUCT_PRODUCT_PROPERTIES += \
    ro.custom.device=$(CUSTOM_BUILD) \
    ro.custom.fingerprint=$(ROM_FINGERPRINT) \
    ro.custom.version=$(CUSTOM_VERSION) \
    ro.modversion=$(CUSTOM_VERSION) \
    org.skylineui.build_date=$(BUILD_DATE) \
    org.skylineui.build_date_utc=$(CUSTOM_BUILD_DATE_UTC) \
    org.skylineui.build_version=$(SKYLINEUI_BUILD_VERSION) \
    org.skylineui.build_type=$(CUSTOM_BUILD_TYPE) \
    org.skylineui.version.display=$(CUSTOM_VERSION) \
    ro.skylineui.maintainer=$(SKYLINEUI_MAINTAINER)

# SkylineUI Release
ifeq ($(CUSTOM_BUILD_TYPE), OFFICIAL)
  OFFICIAL_DEVICES = $(shell cat vendor/aosp/skylineui.devices)
  FOUND_DEVICE =  $(filter $(CUSTOM_BUILD), $(OFFICIAL_DEVICES))
    ifeq ($(FOUND_DEVICE),$(CUSTOM_BUILD))
      CUSTOM_BUILD_TYPE := OFFICIAL
    else
      CUSTOM_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(CUSTOM_BUILD)")
    endif
endif

# Signing
ifneq (eng,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard vendor/aosp/signing/keys/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/aosp/signing/keys/releasekey
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
ifneq (,$(wildcard vendor/aosp/signing/keys/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := vendor/aosp/signing/keys/otakey.x509.pem
endif
endif
