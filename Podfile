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

pod 'ApplePayStubs', :head
pod 'ContentfulStyle', :git => 'git@github.com:contentful/contentful-ios-style.git'
pod 'Masonry'
pod 'TSMiniWebBrowser@dblock'

end
