# Copyright (C) 2018 HashOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Versioning System
PRODUCT_VERSION_MAJOR = 9
PRODUCT_VERSION_MINOR = 0

DATE := $(shell date +%Y%m%d)

HASH_BUILDTYPE ?= Semi-Alpha
HASH_BUILD_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)
HASH_VERSION := $(HASH_BUILD_VERSION)-$(DATE)-$(HASH_BUILD)-$(HASH_BUILDTYPE)
HASH_FINGERPRINT := HashOS/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date +%Y%m%d.%H:%M)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.hash.build.version=$(HASH_BUILD_VERSION) \
  ro.hash.build.date=$(DATE) \
  ro.hash.buildtype=$(HASH_BUILDTYPE) \
  ro.hash.version=$(HASH_VERSION) \
  ro.hash.device=$(HASH_BUILD) \
  ro.modversion=$(HASH_VERSION)
  ro.hash.fingerprint=$(HASH_FINGERPRINT)
