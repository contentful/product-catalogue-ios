//
//  LoginViewController.m
//  Product Catalogue
//
//  Created by Boris Bügling on 26/01/15.
//  Copyright (c) 2015 Boris Bügling. All rights reserved.
//

#import "CMAProductCatalogueVerifier.h"
#import "LoginViewController.h"

@implementation LoginViewController

-(void)awakeFromNib {
    [super awakeFromNib];

    self.spaceVerifier = [CMAProductCatalogueVerifier new];
}

@end
