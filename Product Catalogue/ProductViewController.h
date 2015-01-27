//
//  ProductViewController.h
//  Product Catalogue
//
//  Created by Boris Bügling on 18/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Product.h"
#import "UIScrollingViewController.h"

@interface ProductViewController : UIScrollingViewController

@property (nonatomic, weak) CDAClient* client;
@property (nonatomic, weak) Product* product;

@end
