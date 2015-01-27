//
//  ProductViewController.m
//  Product Catalogue
//
//  Created by Boris Bügling on 18/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <ContentfulStyle/UIColor+Contentful.h>
#import <ContentfulStyle/UIFont+Contentful.h>
#import <DZNWebViewController/DZNWebViewController.h>
#import <QuartzCore/QuartzCore.h>

#import "Brand.h"
#import "BrandDetailsViewController.h"
#import "GalleryViewController.h"
#import "ProductViewController.h"
#import "StoryboardIdentifiers.h"

@interface ProductViewController ()

@property (weak, nonatomic) IBOutlet UILabel *availabilityLabel;
@property (weak, nonatomic) IBOutlet UIButton *brandButton;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UILabel *byLabel;
@property (weak, nonatomic) IBOutlet UILabel *pricingLabel;
@property (weak, nonatomic) IBOutlet UITextView *productDescription;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeTypeColorTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeTypeColorLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsTitleLabel;

@end

#pragma mark -

@implementation ProductViewController

-(CGFloat)contentHeight {
    return 450.0 + self.productNameLabel.intrinsicContentSize.height + self.productDescription.intrinsicContentSize.height;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:EmbedGalleryVCSegue]) {
        GalleryViewController* galleryVC = segue.destinationViewController;
        galleryVC.assets = [self.product.image.array
                            subarrayWithRange:NSMakeRange(0, MIN(self.product.image.count, 5))];
        galleryVC.client = self.client;
    }

    if ([segue.identifier isEqualToString:ShowBrandDetailsSegue]) {
        BrandDetailsViewController* brandVC = segue.destinationViewController;
        brandVC.brand = self.product.brand;
        brandVC.client = self.client;
    }
}

-(void)showURL:(NSURL*)URL {
    DZNWebViewController* browser = [[DZNWebViewController alloc] initWithURL:URL];
    browser.supportedWebActions = DZNWebActionNone;
    browser.supportedWebNavigationTools = DZNWebNavigationToolNone;
    [self.navigationController pushViewController:browser animated:YES];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.productDescription.selectable = NO;
}

-(void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    self.availabilityLabel.font = [UIFont bodyTextFont];
    self.availabilityLabel.textColor = [UIColor contentfulDeactivatedColor];
    self.brandButton.titleLabel.font = [UIFont buttonTitleFont];
    self.buyButton.titleLabel.font = [UIFont buttonTitleFont];
    self.byLabel.font = [UIFont buttonTitleFont];
    self.pricingLabel.font = [UIFont bodyTextFont];
    self.productDescription.font = [UIFont bodyTextFont];
    self.productNameLabel.font = [UIFont bodyTextFont];
    self.sizeTypeColorLabel.font = [UIFont bodyTextFont];
    self.sizeTypeColorTitleLabel.font = [UIFont bodyTextFont];
    self.tagsLabel.font = [UIFont bodyTextFont];
    self.tagsTitleLabel.font = [UIFont bodyTextFont];

    self.buyButton.backgroundColor = [UIColor contentfulPrimaryColor];
    self.buyButton.layer.cornerRadius = 4.0;
    self.buyButton.tintColor = [UIColor whiteColor];

    self.brandButton.enabled = self.product.brand != nil;

    [self.buyButton addTarget:self action:@selector(buyButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    self.buyButton.enabled = self.product.website.length > 0;

    self.title = self.product.productName;

    if (self.product.quantity.integerValue == 0) {
        self.availabilityLabel.text = NSLocalizedString(@"No products\nin stock",
                                                        @"Product quantity label");
    } else if (self.product.quantity.integerValue == 1) {

    } else {
        self.availabilityLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@ items in stock", @"Product quantity label"), self.product.quantity];
    }

    [self.brandButton setTitle:[NSString stringWithFormat:NSLocalizedString(@"by %@", @"Brand button"), self.product.brand.companyName] forState:UIControlStateNormal];
    self.pricingLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@ EUR", @"Pricing label"), self.product.price];
    self.productDescription.text = self.product.productDescription;
    self.productNameLabel.text = self.product.productName;
    self.sizeTypeColorLabel.text = self.product.sizetypecolor;

    NSArray* tagsArray = [NSKeyedUnarchiver unarchiveObjectWithData:self.product.tags];
    self.tagsLabel.text = [tagsArray componentsJoinedByString:@", "];
}

#pragma mark - Actions

-(void)buyButtonTapped {
    NSURL* URL = [NSURL URLWithString:self.product.website];
    [self showURL:URL];
}

@end
