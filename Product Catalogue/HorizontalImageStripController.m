//
//  HorizontalImageStripController.m
//  Product Catalogue
//
//  Created by Boris Bügling on 22/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <ContentfulDeliveryAPI/ContentfulDeliveryAPI.h>
#import <ContentfulDeliveryAPI/UIImageView+CDAAsset.h>

#import "SingleImageCell.h"
#import "HorizontalImageStripController.h"

@implementation HorizontalImageStripController

-(instancetype)init {
    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(40.0, 40.0);
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing = 10.0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self = [super initWithCollectionViewLayout:layout];
    return self;
}

-(void)refresh {
    [self.collectionView reloadData];
}

-(void)scrollToItemAtIndex:(NSUInteger)itemIndex {
    for (NSIndexPath* indexPath in self.collectionView.indexPathsForSelectedItems) {
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }

    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];

    [self.collectionView selectItemAtIndexPath:indexPath
                                      animated:NO
                                scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}

-(void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.backgroundColor = [UIColor clearColor];
    self.view.userInteractionEnabled = NO;

    [self.collectionView registerClass:SingleImageCell.class
            forCellWithReuseIdentifier:NSStringFromClass(self.class)];
}

#pragma mark - UICollectionViewDataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SingleImageCell* cell = (SingleImageCell*)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];

    [cell.imageView cda_setImageWithPersistedAsset:self.assets[indexPath.row]
                                            client:self.client
                                              size:CGSizeZero
                                  placeholderImage:nil];

    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assets.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

@end
