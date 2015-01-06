//
//  ProductViewController.m
//  Product Catalogue
//
//  Created by Boris Bügling on 18/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ApplePayStubs/STPTestPaymentAuthorizationViewController.h>
#import <ContentfulStyle/UIColor+Contentful.h>
#import <ContentfulStyle/UIFont+Contentful.h>
#import <TSMiniWebBrowser@dblock/TSMiniWebBrowser.h>

#import "Brand.h"
#import "GalleryViewController.h"
#import "ProductViewController.h"
#import "StoryboardIdentifiers.h"

@interface ProductViewController () <PKPaymentAuthorizationViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *availabilityLabel;
@property (weak, nonatomic) IBOutlet UIButton *brandButton;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UILabel *pricingLabel;
@property (weak, nonatomic) IBOutlet UITextView *productDescription;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;

@end

#pragma mark -

@implementation ProductViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:EmbedGalleryVCSegue]) {
        GalleryViewController* galleryVC = segue.destinationViewController;
        galleryVC.assets = self.product.image;
        galleryVC.client = self.client;
        
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.productDescription.contentOffset = CGPointZero;
}

-(void)viewDidLoad {
    [super viewDidLoad];

    self.availabilityLabel.font = [UIFont bodyTextFont];
    self.availabilityLabel.textColor = [UIColor contentfulDeactivatedColor];
    self.brandButton.titleLabel.font = [UIFont buttonTitleFont];
    self.buyButton.titleLabel.font = [UIFont buttonTitleFont];
    self.pricingLabel.font = [UIFont bodyTextFont];
    self.productDescription.font = [UIFont bodyTextFont];
    self.productNameLabel.font = [UIFont bodyTextFont];

    self.buyButton.backgroundColor = [UIColor contentfulPrimaryColor];
    self.buyButton.tintColor = [UIColor whiteColor];

    [self.brandButton addTarget:self
                         action:@selector(brandButtonTapped)
               forControlEvents:UIControlEventTouchUpInside];

    [self.buyButton addTarget:self action:@selector(buyButtonTapped) forControlEvents:UIControlEventTouchUpInside];

    self.title = self.product.productName;

    if (self.product.quantity.integerValue == 0) {
        self.availabilityLabel.text = NSLocalizedString(@"No products\nin stock",
                                                        @"Product quantity label");
    } else if (self.product.quantity.integerValue == 1) {

    } else {
        self.availabilityLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@ items\nin stock", @"Product quantity label"), self.product.quantity];
    }

    [self.brandButton setTitle:[NSString stringWithFormat:NSLocalizedString(@"by %@", @"Brand button"), self.product.brand.companyName] forState:UIControlStateNormal];
    self.pricingLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@\nEUR", @"Pricing label"), self.product.price];
    self.productDescription.text = self.product.productDescription;
    self.productNameLabel.text = self.product.productName;
}

#pragma mark - Actions

-(void)brandButtonTapped {
    NSURL* URL = [NSURL URLWithString:self.product.brand.website];
    TSMiniWebBrowser* browser = [[TSMiniWebBrowser alloc] initWithURL:URL];
    [self.navigationController pushViewController:browser animated:YES];
}

-(void)buyButtonTapped {
    NSDecimalNumber* price = [NSDecimalNumber decimalNumberWithDecimal:self.product.price.decimalValue];

    PKPaymentRequest* request = [PKPaymentRequest new];
    request.currencyCode = @"EUR";
    request.paymentSummaryItems = @[ [PKPaymentSummaryItem summaryItemWithLabel:self.product.productName
                                                                         amount:price] ];

    STPTestPaymentAuthorizationViewController* viewController = [[STPTestPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
    viewController.delegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - PKPaymentAuthorizationViewControllerDelegate

-(void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion {
    completion(PKPaymentAuthorizationStatusSuccess);
}

@end
