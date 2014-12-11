//
//  AppDelegate.m
//  Product Catalogue
//
//  Created by Boris Bügling on 10/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <CocoaPods-Keys/ProductCatalogueKeys.h>

#import "AppDelegate.h"
#import "Constants.h"

@interface AppDelegate ()

@end

#pragma mark -

@implementation AppDelegate

- (BOOL)application:(UIApplication *)app didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self writeKeysToUserDefaults];
    return YES;
}

-(void)writeKeysToUserDefaults {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    ProductCatalogueKeys* keys = [ProductCatalogueKeys new];

    if (![defaults stringForKey:SPACE_KEY]) {
        [defaults setValue:keys.productCatalogueSpaceId forKey:SPACE_KEY];
    }

    if (![defaults stringForKey:ACCESS_TOKEN]) {
        [defaults setValue:keys.productCatalogueAccesToken forKey:ACCESS_TOKEN];
    }
}

@end
