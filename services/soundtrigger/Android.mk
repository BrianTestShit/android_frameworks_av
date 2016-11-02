# Copyright 2014 The Android Open Source Project
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

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

ifeq ($(SOUND_TRIGGER_USE_STUB_MODULE), 1)
    LOCAL_CFLAGS += -DSOUND_TRIGGER_USE_STUB_MODULE
endif

LOCAL_SRC_FILES:=               \
    SoundTriggerHwService.cpp

LOCAL_SHARED_LIBRARIES:= \
    liblog \
    libutils \
    libbinder \
    libcutils \
    libhardware \
    libsoundtrigger \
    libaudioclient \
    libserviceutility


ifeq ($(ENABLE_TREBLE),true)
# Treble configuration
LOCAL_CFLAGS += -DENABLE_TREBLE
LOCAL_SRC_FILES +=               \
    SoundTriggerHalHidl.cpp

LOCAL_SHARED_LIBRARIES += \
		libhwbinder \
		libhidl \
		libbase \
		android.hardware.soundtrigger@2.0 \
		android.hardware.audio.common@2.0
else
# libhardware configuration
LOCAL_SRC_FILES +=               \
    SoundTriggerHalLegacy.cpp
endif


LOCAL_C_INCLUDES += \
    $(TOPDIR)frameworks/av/services/audioflinger

LOCAL_MULTILIB := $(AUDIOSERVER_MULTILIB)

LOCAL_CFLAGS += -Wall -Werror

LOCAL_MODULE:= libsoundtriggerservice

include $(BUILD_SHARED_LIBRARY)
