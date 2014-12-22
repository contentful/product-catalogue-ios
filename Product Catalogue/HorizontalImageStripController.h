//
//  HorizontalImageStripController.h
//  Product Catalogue
//
//  Created by Boris Bügling on 22/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDAClient;

@interface HorizontalImageStripController : UICollectionViewController

@property (nonatomic, weak) NSOrderedSet* assets;
@property (nonatomic, weak) CDAClient* client;

-(void)refresh;
-(void)scrollToItemAtIndex:(NSUInteger)itemIndex;

@end
