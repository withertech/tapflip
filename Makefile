ARCHS = armv7 arm64 arm64e
TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = com.apple.camera


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = tapflip
tapflip_FRAMEWORKS = UIKit
tapflip_PRIVATE_FRAMEWORKS = CameraUI
tapflip_FILES = Tweak.xm
tapflip_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk


SUBPROJECTS += tapflipprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
