plugin 'cocoapods-keys', {
  :project => 'Product Catalogue',
  :keys => [
    'ProductCatalogueSpaceId',
    'ProductCatalogueAccesToken'
  ]}

platform :ios, '8.0'

inhibit_all_warnings!

target 'Product Catalogue' do

#use_frameworks!

# work with a local copy for simplicity's sake
pod 'ContentfulPersistence', :path => '../contentful-persistence.objc'

pod 'ContentfulDialogs', :git => 'git@github.com:contentful/contentful-ios-dialogs.git'
pod 'ContentfulStyle', :git => 'git@github.com:contentful/contentful-ios-style.git'
pod 'DZNWebViewController', :git => 'git@github.com:neonichu/DZNWebViewController.git'
pod 'Masonry'
pod 'TPKeyboardAvoiding'

end
