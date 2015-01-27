//
//  BrandDetailsViewController.h
//  Product Catalogue
//
//  Created by Boris Bügling on 27/01/15.
//  Copyright (c) 2015 Boris Bügling. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Brand.h"
#import "UIScrollingViewController.h"

@class CDAClient;

@interface BrandDetailsViewController : UIScrollingViewController

@property (nonatomic, weak) Brand* brand;
@property (nonatomic, weak) CDAClient* client;

@end
