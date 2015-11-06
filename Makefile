# read value from Contentful configuration
get_config = $(shell grep -A 2 $1 ~/.contentfulrc|grep $2|cut -d' ' -f3)

.PHONY: all bootstrap setup storyboard_ids

SPACE_NAME=my_catalogue

all:
	xcodebuild -workspace 'Product Catalogue.xcworkspace' \
		-scheme 'Product Catalogue'|xcpretty

setup:
	@pod keys set ProductCatalogueSpaceId $(call get_config,$(SPACE_NAME),SPACE_ID)
	@pod keys set ProductCatalogueAccesToken $(call get_config,$(SPACE_NAME),CONTENTFUL_DELIVERY_ACCESS_TOKEN)
	bundle exec pod install --no-repo-update

storyboard_ids:
	bundle exec sbconstants Product\ Catalogue/StoryboardIdentifiers.h
