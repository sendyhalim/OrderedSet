platform = --platform ios
xcode_flags = -project "OrderedSet.xcodeproj" -scheme "OrderedSet" -configuration "Release" DSTROOT=/tmp/OrderedSet.dst
xcode_flags_test = -project "OrderedSet.xcodeproj" -scheme "OrderedSet" -configuration "Debug"
components_plist = "Supporting Files/Components.plist"
temporary_dir = /tmp/OrderedSet.dst

bootstrap:
	carthage bootstrap $(platform)

update:
	carthage update $(platform)

synx:
	synx OrderedSet.xcodeproj

clean:
	rm -rf $(temporary_dir)
	xcodebuild $(xcode_flags) clean

test: clean bootstrap
	xcodebuild $(xcode_flags_test) test

lint:
	swiftlint

.PHONY: bootstrap update synx clean test lint
