//
//  GalleryViewController.h
//  Product Catalogue
//
//  Created by Boris Bügling on 18/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDAClient;

@interface GalleryViewController : UIPageViewController

@property (nonatomic, weak) NSOrderedSet* assets;
@property (nonatomic, weak) CDAClient* client;

@end
