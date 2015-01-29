.PHONY: all setup storyboard_ids

all:
	xcodebuild -workspace 'Product Catalogue.xcworkspace' \
		-scheme 'Product Catalogue'|xcpretty

setup:
	bundle install
	bundle exec pod install

storyboard_ids:
	bundle exec sbconstants Product\ Catalogue/StoryboardIdentifiers.h
