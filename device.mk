#
# Copyright (C) 2021 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/infinix/X657C

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Inherit common Android Go defaults.
$(call inherit-product, build/make/target/product/go_defaults.mk)

# Get non-open-source specific aspects
$(call inherit-product, vendor/infinix/X657C/X657C-vendor.mk)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/audio_policy_configuration.xml

# Camera
PRODUCT_PACKAGES += \
    GoogleCameraGo

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay

# Dynamic Partitions 
PRODUCT_TARGET_VNDK_VERSION := 29
PRODUCT_SHIPPING_API_LEVEL := 29
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Ramdisk
PRODUCT_PACKAGES += \
    init.mt6761.rc \
    init.safailnet.rc \
    fstab.mt6761

# DT2W
PRODUCT_PACKAGES += \
    DT2W-Service-X657C

# Fstab
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/etc/fstab.mt6761:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6761

# Keylayout
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/keylayout/ACCDET.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/ACCDET.kl \
    $(DEVICE_PATH)/configs/keylayout/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0_system \
    android.hidl.manager@1.0_system

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

    # [DNM] Temp permissions
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/permissions/xyz.extras.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/xyz.extras.xml 
    
# Light
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.X657C

# NFC stack (AOSP)
PRODUCT_PACKAGES += \
    NfcNci

# KPOC
PRODUCT_PACKAGES += \
    libsuspend \
    android.hardware.health@2.0

# IMS
PRODUCT_BOOT_JARS += \
    mediatek-common \
    mediatek-framework \
    mediatek-ims-base \
    mediatek-ims-common \
    mediatek-telecom-common \
    mediatek-telephony-base \
    mediatek-telephony-common

#LTS Permissions
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/lts-privapp-permissions.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/lts-privapp-permissions.xml \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-X657C.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-X657C.xml \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-imsinit.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-imsinit.xml 

# Memory optimizations
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.qti.sys.fw.bservice_enable=true \
    ro.vendor.qti.sys.fw.bservice_limit=5 \
    ro.vendor.qti.sys.fw.bservice_age=5000
    
# zRam
PRODUCT_PACKAGES += \
    set_zram.sh

