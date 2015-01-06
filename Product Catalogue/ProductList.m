//
//  ProductList.m
//  Product Catalogue
//
//  Created by Boris Bügling on 10/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <ContentfulPersistence/CoreDataFetchDataSource.h>
#import <ContentfulDeliveryAPI/ContentfulDeliveryAPI.h>
#import <ContentfulDeliveryAPI/UIImageView+CDAAsset.h>

#import "ContentfulDataManager.h"
#import "Product.h"
#import "ProductCell.h"
#import "ProductViewController.h"
#import "StoryboardIdentifiers.h"
#import "ProductList.h"

@interface ProductList () <UICollectionViewDelegate>

@property (nonatomic, strong) ContentfulDataManager* dataManager;
@property (nonatomic, readonly) CoreDataFetchDataSource* dataSource;

@end

#pragma mark -

@implementation ProductList

@synthesize dataSource = _dataSource;

#pragma mark -

- (CoreDataFetchDataSource *)dataSource {
    if (_dataSource) {
        return _dataSource;
    }

    self.dataManager = [ContentfulDataManager new];

    NSFetchedResultsController* controller = [self.dataManager fetchedResultsControllerForContentTypeWithIdentifier:ProductContentTypeId predicate:self.predicate sortDescriptors:@[ [[NSSortDescriptor alloc] initWithKey:@"productName" ascending:YES] ]];
    _dataSource = [[CoreDataFetchDataSource alloc] initWithFetchedResultsController:controller collectionView:self.collectionView cellIdentifier:NSStringFromClass([self class])];

    __weak typeof(self) welf = self;
    _dataSource.cellConfigurator = ^(ProductCell* cell, NSIndexPath* indexPath) {
        Product* product = [welf.dataSource objectAtIndexPath:indexPath];
        cell.coverImageView.offlineCaching_cda = YES;
        [cell.coverImageView cda_setImageWithPersistedAsset:[product.image firstObject]
                                                     client:welf.dataManager.client
                                                       size:CGSizeZero
                                           placeholderImage:[UIImage imageNamed:@"placeholder"]];

        cell.pricingLabel.text = [NSString stringWithFormat:@"%@ €", product.price];
    };

    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.dataSource = self.dataSource;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    [self.collectionView registerClass:ProductCell.class
            forCellWithReuseIdentifier:NSStringFromClass(self.class)];

    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((int)self.view.frame.size.width / 2,
                                 (int)(self.view.frame.size.height / 3));
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing = 0.0;
    [self.collectionView setCollectionViewLayout:layout];

    self.tabBarController.view.userInteractionEnabled = NO;

    [self.dataManager performSynchronizationWithSuccess:^{
        [self.dataSource performFetch];

        self.tabBarController.view.userInteractionEnabled = YES;
    } failure:^(CDAResponse *response, NSError *error) {
        // FIXME: For brevity's sake, we do not check the cause of the error, but a real app should.
        [self.dataSource performFetch];

        self.tabBarController.view.userInteractionEnabled = YES;
    }];
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductViewController* detail = [self.storyboard instantiateViewControllerWithIdentifier:ProductViewControllerSegue];
    detail.client = self.dataManager.client;
    detail.product = [self.dataSource objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
