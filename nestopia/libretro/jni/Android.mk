GIT_VERSION := " $(shell git describe --dirty --always --tags)"

LOCAL_SHORT_COMMANDS := true

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := libretro

ifeq ($(TARGET_ARCH),arm)
LOCAL_CFLAGS += -DANDROID_ARM
LOCAL_ARM_MODE := arm
endif

ifeq ($(TARGET_ARCH),x86)
LOCAL_CFLAGS +=  -DANDROID_X86
endif

ifeq ($(TARGET_ARCH),mips)
LOCAL_CFLAGS += -DANDROID_MIPS
endif

CORE_DIR = ../..

include $(CORE_DIR)/libretro/Makefile.common

LOCAL_SRC_FILES += $(SOURCES_CXX) $(SOURCES_C)
LOCAL_CFLAGS += -DGIT_VERSION=\"$(GIT_VERSION)\"
LOCAL_CXXFLAGS += -DANDROID -D__LIBRETRO__ -DINLINE=inline -DHAVE_STDINT_H -DHAVE_INTTYPES_H -DNST_NO_ZLIB -fexceptions -DGIT_VERSION=\"$(GIT_VERSION)\" $(INCFLAGS)

include $(BUILD_SHARED_LIBRARY)