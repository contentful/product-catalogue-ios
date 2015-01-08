.PHONY: all storyboard_ids

all:
	xcodebuild -workspace 'Product Catalogue.xcworkspace' \
		-scheme 'Product Catalogue'|xcpretty

storyboard_ids:
	bundle exec sbconstants Product\ Catalogue/StoryboardIdentifiers.h
