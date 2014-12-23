//
//  ProductViewController.m
//  Product Catalogue
//
//  Created by Boris Bügling on 18/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import "Brand.h"
#import "GalleryViewController.h"
#import "ProductViewController.h"
#import "StoryboardIdentifiers.h"

@interface ProductViewController ()

@property (weak, nonatomic) IBOutlet UILabel *availabilityLabel;
@property (weak, nonatomic) IBOutlet UIButton *brandButton;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UILabel *pricingLabel;
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

-(void)viewDidLoad {
    [super viewDidLoad];

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
    self.productNameLabel.text = self.product.productName;
}

@end
