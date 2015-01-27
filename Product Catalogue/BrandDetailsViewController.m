//
//  BrandDetailsViewController.m
//  Product Catalogue
//
//  Created by Boris Bügling on 27/01/15.
//  Copyright (c) 2015 Boris Bügling. All rights reserved.
//

#import <ContentfulDeliveryAPI/ContentfulDeliveryAPI.h>
#import <ContentfulStyle/UIFont+Contentful.h>

#import "Asset.h"
#import "BrandDetailsViewController.h"

@interface BrandDetailsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *brandDescription;
@property (weak, nonatomic) IBOutlet UIImageView *brandLogoView;

@end

#pragma mark -

@implementation BrandDetailsViewController

-(CGFloat)contentHeight {
    return 150.0 + self.brandDescription.intrinsicContentSize.height;
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.brandDescription.selectable = NO;
}

-(void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    self.brandDescription.font = [UIFont bodyTextFont];

    self.brandLogoView.offlineCaching_cda = YES;
    [self.brandLogoView cda_setImageWithPersistedAsset:self.brand.logo
                                                client:self.client
                                                  size:CGSizeMake(100.0, 100.0)
                                      placeholderImage:[UIImage imageNamed:@"placeholder"]];

    self.brandDescription.text = self.brand.companyDescription;
    self.title = self.brand.companyName;
}

@end
