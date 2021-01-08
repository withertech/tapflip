TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = tapflipprefs

tapflipprefs_FILES = TAPRootListController.m
tapflipprefs_FRAMEWORKS = UIKit
tapflipprefs_PRIVATE_FRAMEWORKS = Preferences
tapflipprefs_INSTALL_PATH = /Library/PreferenceBundles
tapflipprefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
