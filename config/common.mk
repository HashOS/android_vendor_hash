PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.build.selinux=1 \
    ro.carrier=unknown

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# LatinIME gesture typing
ifeq ($(TARGET_ARCH),arm64)
PRODUCT_COPY_FILES += \
    vendor/hash/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/hash/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/hash/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/hash/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
endif

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

#permissions
PRODUCT_COPY_FILES += \
    vendor/hash/prebuilt/etc/permissions/privapp-permissions-hash.xml:system/etc/permissions/privapp-permissions-hash.xml \
    vendor/hash/prebuilt/etc/permissions/privapp-permissions-elgoog.xml:system/etc/permissions/privapp-permissions-elgoog.xml

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/hash/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/hash/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/hash/prebuilt/common/bin/50-hash.sh:system/addon.d/50-base.sh \

PRODUCT_COPY_FILES += \
    vendor/hash/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/hash/prebuilt/common/bin/sysinit:system/bin/sysinit

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/hash/prebuilt/common/etc/mkshrc:system/etc/mkshrc

# Copy all Hash-specific init rc files
$(foreach f,$(wildcard vendor/hash/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Disable Rescue Party
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.disable_rescue=true

# Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# exFAT tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    mkfs.exfat

# Add our overlays
DEVICE_PACKAGE_OVERLAYS += vendor/hash/overlay/common

# Bootanimation
include vendor/hash/config/bootanimation.mk

# Packages
include vendor/hash/config/packages.mk

# Versioning
include vendor/hash/config/version.mk
