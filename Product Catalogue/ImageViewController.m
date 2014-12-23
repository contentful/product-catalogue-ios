//
//  ImageViewController.m
//  Product Catalogue
//
//  Created by Boris Bügling on 18/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <ContentfulDeliveryAPI/ContentfulDeliveryAPI.h>
#import <Masonry/Masonry.h>

#import "ImageViewController.h"

@implementation ImageViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        self.padding = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSParameterAssert(self.asset);
    NSParameterAssert(self.client);

    UIImageView* imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView cda_setImageWithPersistedAsset:self.asset
                                       client:self.client
                                         size:CGSizeZero
                             placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [self.view addSubview:imageView];

    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(self.padding);
    }];
}

@end
