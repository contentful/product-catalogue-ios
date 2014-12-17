//
//  ViewController.m
//  Product Catalogue
//
//  Created by Boris Bügling on 10/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <ContentfulPersistence/CoreDataManager.h>
#import <ContentfulPersistence/CoreDataFetchDataSource.h>
#import <ContentfulDeliveryAPI/UIImageView+CDAAsset.h>

#import "Asset.h"
#import "Brand.h"
#import "Constants.h"
#import "Product.h"
#import "ProductCategory.h"
#import "ProductCell.h"
#import "SyncInfo.h"
#import "ViewController.h"

// TODO: This won't work when we enable space selection
static NSString* const BrandContentTypeId = @"sFzTZbSuM8coEwygeUYes";
static NSString* const CategoryContentTypeId = @"6XwpTaSiiI2Ak2Ww0oi6qa";
static NSString* const ProductContentTypeId = @"2PqfXUJwE8qSYKuM0U6w8M";

@interface ViewController ()

@property (nonatomic, readonly) CoreDataFetchDataSource* dataSource;
@property (nonatomic, readonly) CoreDataManager* manager;

@end

#pragma mark -

@implementation ViewController

@synthesize dataSource = _dataSource;
@synthesize manager = _manager;

#pragma mark -

- (CoreDataFetchDataSource *)dataSource {
    if (_dataSource) {
        return _dataSource;
    }

    NSFetchRequest* fetchRequest = [self.manager fetchRequestForEntriesOfContentTypeWithIdentifier:ProductContentTypeId matchingPredicate:nil];

    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"productName" ascending:YES];
    NSArray *sortDescriptors = @[nameDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];

    NSFetchedResultsController* controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.manager.managedObjectContext sectionNameKeyPath:nil cacheName:nil];

    _dataSource = [[CoreDataFetchDataSource alloc] initWithFetchedResultsController:controller collectionView:self.collectionView cellIdentifier:NSStringFromClass([self class])];

    __weak typeof(self) welf = self;
    _dataSource.cellConfigurator = ^(ProductCell* cell, NSIndexPath* indexPath) {
        Product* product = [welf.dataSource objectAtIndexPath:indexPath];
        [cell.coverImageView cda_setImageWithPersistedAsset:[product.image firstObject]
                                                     client:welf.manager.client
                                                       size:CGSizeZero
                                           placeholderImage:nil];

        cell.pricingLabel.text = [NSString stringWithFormat:@"%@ €", product.price];
        [cell.pricingLabel sizeToFit];
    };

    return _dataSource;
}

- (CoreDataManager *)manager {
    if (_manager) {
        return _manager;
    }

    _manager = [[CoreDataManager alloc] initWithClient:[[CDAClient alloc] initWithSpaceKey:[[NSUserDefaults standardUserDefaults] stringForKey:SPACE_KEY] accessToken:[[NSUserDefaults standardUserDefaults] stringForKey:ACCESS_TOKEN]] dataModelName:@"ProductCatalog"];

    _manager.classForAssets = [Asset class];
    _manager.classForSpaces = [SyncInfo class];

    [_manager setClass:Brand.class forEntriesOfContentTypeWithIdentifier:BrandContentTypeId];
    [_manager setClass:Product.class forEntriesOfContentTypeWithIdentifier:ProductContentTypeId];
    [_manager setClass:ProductCategory.class forEntriesOfContentTypeWithIdentifier:CategoryContentTypeId];

    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.dataSource = self.dataSource;

    [self.collectionView registerClass:ProductCell.class
            forCellWithReuseIdentifier:NSStringFromClass(self.class)];

    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(self.view.frame.size.width, 300.0);
    layout.minimumLineSpacing = 5.0;
    [self.collectionView setCollectionViewLayout:layout];

    [self.manager performSynchronizationWithSuccess:^{
        [self.dataSource performFetch];
    } failure:^(CDAResponse *response, NSError *error) {
        // FIXME: For brevity's sake, we do not check the cause of the error, but a real app should.
        [self.dataSource performFetch];
    }];
}

@end
