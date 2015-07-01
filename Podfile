plugin 'cocoapods-keys', {
  :project => 'Product Catalogue',
  :keys => [
    'ProductCatalogueSpaceId',
    'ProductCatalogueAccesToken'
  ]}
#plugin 'cocoapods-stats'

source 'https://github.com/CocoaPods/Specs'
source 'https://github.com/contentful/CocoaPodsSpecs'

platform :ios, '8.0'

inhibit_all_warnings!

target 'Product Catalogue' do

#use_frameworks!

pod 'ContentfulDeliveryAPI', '~> 1.4.9'
pod 'ContentfulDialogs'
pod 'ContentfulPersistence'
pod 'ContentfulStyle'
pod 'DZNWebViewController', :git => 'git@github.com:neonichu/DZNWebViewController.git'
pod 'Masonry'

end

target 'Tests' do

pod 'FBSnapshotTestcase', '~> 1.8.1'

end
