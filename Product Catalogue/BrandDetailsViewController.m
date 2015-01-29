//
//  BrandDetailsViewController.m
//  Product Catalogue
//
//  Created by Boris Bügling on 27/01/15.
//  Copyright (c) 2015 Boris Bügling. All rights reserved.
//

#import <ContentfulDeliveryAPI/ContentfulDeliveryAPI.h>
#import <ContentfulStyle/UIColor+Contentful.h>
#import <ContentfulStyle/UIFont+Contentful.h>
#import <DZNWebViewController/DZNWebViewController.h>

#import "Asset.h"
#import "BrandDetailsViewController.h"

@interface BrandDetailsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *brandDescription;
@property (weak, nonatomic) IBOutlet UIImageView *brandLogoView;
@property (weak, nonatomic) IBOutlet UIButton *brandWebsiteButton;

@end

#pragma mark -

@implementation BrandDetailsViewController

-(CGFloat)contentHeight {
    return 200.0 + self.brandDescription.intrinsicContentSize.height;
}

-(void)showURL:(NSURL*)URL {
    DZNWebViewController* browser = [[DZNWebViewController alloc] initWithURL:URL];
    browser.supportedWebActions = DZNWebActionNone;
    browser.supportedWebNavigationTools = DZNWebNavigationToolNone;
    [self.navigationController pushViewController:browser animated:YES];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.brandDescription.selectable = NO;
}

-(void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    self.brandDescription.font = [UIFont bodyTextFont];
    self.brandWebsiteButton.titleLabel.font = [UIFont buttonTitleFont];

    self.brandLogoView.offlineCaching_cda = YES;
    [self.brandLogoView cda_setImageWithPersistedAsset:self.brand.logo
                                                client:self.client
                                                  size:CGSizeMake(100.0, 100.0)
                                      placeholderImage:[UIImage imageNamed:@"placeholder"]];

    self.brandDescription.text = self.brand.companyDescription;
    self.title = self.brand.companyName;

    [self.brandWebsiteButton addTarget:self action:@selector(websiteButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    self.brandWebsiteButton.hidden = self.brand.website.length == 0;
}

#pragma mark - Actions

-(void)websiteButtonTapped {
    NSURL* URL = [NSURL URLWithString:self.brand.website];
    [self showURL:URL];
}

@end
