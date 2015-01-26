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

@end

#pragma mark -

@implementation ProductViewController

-(void)loadView {
    [super loadView];

    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:self.view];

    self.view = scrollView;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:EmbedGalleryVCSegue]) {
        GalleryViewController* galleryVC = segue.destinationViewController;
        galleryVC.assets = self.product.image;
        galleryVC.client = self.client;
    }
}

-(void)showURL:(NSURL*)URL {
    DZNWebViewController* browser = [[DZNWebViewController alloc] initWithURL:URL];
    browser.supportedWebActions = DZNWebActionNone;
    browser.supportedWebNavigationTools = DZNWebNavigationToolNone;
    [self.navigationController pushViewController:browser animated:YES];
}

-(void)updateContentSizeToHeight:(CGFloat)height {
    UIView* contentView = self.view.subviews[0];
    contentView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, height);
    ((UIScrollView*)self.view).contentSize = contentView.frame.size;
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGFloat contentHeight = 400.0 + self.productNameLabel.intrinsicContentSize.height + self.productDescription.intrinsicContentSize.height;
    [self updateContentSizeToHeight:contentHeight];

    [self.view layoutIfNeeded];

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

    self.buyButton.backgroundColor = [UIColor contentfulPrimaryColor];
    self.buyButton.layer.cornerRadius = 4.0;
    self.buyButton.tintColor = [UIColor whiteColor];

    [self.brandButton addTarget:self
                         action:@selector(brandButtonTapped)
               forControlEvents:UIControlEventTouchUpInside];
    self.brandButton.enabled = self.product.brand.website.length > 0;

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
}

#pragma mark - Actions

-(void)brandButtonTapped {
    NSURL* URL = [NSURL URLWithString:self.product.brand.website];
    [self showURL:URL];
}

-(void)buyButtonTapped {
    NSURL* URL = [NSURL URLWithString:self.product.website];
    [self showURL:URL];
}

@end
