plugin 'cocoapods-keys', {
  :project => 'Product Catalogue',
  :keys => [
    'ProductCatalogueSpaceId',
    'ProductCatalogueAccesToken'
  ]}

source 'https://github.com/CocoaPods/Specs'
source 'https://github.com/contentful/CocoaPodsSpecs'

platform :ios, '8.0'

inhibit_all_warnings!

target 'Product Catalogue' do

#use_frameworks!

# work with a local copy for simplicity's sake
pod 'ContentfulLogin', :path => '../contentful-ios-login'
pod 'ContentfulPersistence', :path => '../contentful-persistence.objc'

pod 'ContentfulDialogs'
pod 'ContentfulManagementAPI', '~> 0.5.0'
pod 'ContentfulStyle'
pod 'DZNWebViewController', :git => 'git@github.com:neonichu/DZNWebViewController.git'
pod 'Masonry'

end
