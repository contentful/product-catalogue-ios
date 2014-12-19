//
//  ImageViewController.h
//  Product Catalogue
//
//  Created by Boris Bügling on 18/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDAClient;
@protocol CDAPersistedAsset;

@interface ImageViewController : UIViewController

@property (nonatomic, weak) id<CDAPersistedAsset> asset;
@property (nonatomic, weak) CDAClient* client;
@property (nonatomic, assign) UIEdgeInsets padding;

@end
