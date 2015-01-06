//
//  ProductCategoryList.m
//  Product Catalogue
//
//  Created by Boris Bügling on 05/01/15.
//  Copyright (c) 2015 Boris Bügling. All rights reserved.
//

#import <ContentfulPersistence/CoreDataFetchDataSource.h>
#import <ContentfulDeliveryAPI/ContentfulDeliveryAPI.h>

#import "ContentfulDataManager.h"
#import "ProductCategory.h"
#import "ProductCategoryCell.h"
#import "ProductCategoryList.h"
#import "StoryboardIdentifiers.h"
#import "ProductList.h"

@interface ProductCategoryList ()

@property (nonatomic) ContentfulDataManager* dataManager;
@property (nonatomic, readonly) CoreDataFetchDataSource* dataSource;

@end

#pragma mark -

@implementation ProductCategoryList

@synthesize dataSource = _dataSource;

#pragma mark -

- (CoreDataFetchDataSource *)dataSource {
    if (_dataSource) {
        return _dataSource;
    }

    self.dataManager = [ContentfulDataManager new];

    NSFetchedResultsController* controller = [self.dataManager fetchedResultsControllerForContentTypeWithIdentifier:CategoryContentTypeId predicate:nil sortDescriptors:@[ [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] ]];
    _dataSource = [[CoreDataFetchDataSource alloc] initWithFetchedResultsController:controller tableView:self.tableView cellIdentifier:NSStringFromClass([self class])];

    __weak typeof(self) welf = self;
    _dataSource.cellConfigurator = ^(UITableViewCell* cell, NSIndexPath* indexPath) {
        ProductCategory* category = [welf.dataSource objectAtIndexPath:indexPath];

        cell.textLabel.text = category.title;
        cell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%d products", nil), category.categoriesInverse.count];
    };

    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    self.tableView.dataSource = self.dataSource;
    self.tableView.rowHeight = 70.0;

    [self.tableView registerClass:ProductCategoryCell.class forCellReuseIdentifier:NSStringFromClass([self class])];

    [self.dataManager performSynchronizationWithSuccess:^{
        [self.dataSource performFetch];
    } failure:^(CDAResponse *response, NSError *error) {
        // FIXME: For brevity's sake, we do not check the cause of the error, but a real app should.
        [self.dataSource performFetch];
    }];
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductCategory* category = [self.dataSource objectAtIndexPath:indexPath];

    ProductList* filteredProductList = [self.storyboard instantiateViewControllerWithIdentifier:FilteredProductsViewControllerSegue];
    filteredProductList.predicate = [NSString stringWithFormat:@"ANY categories.identifier == '%@'", category.identifier];
    filteredProductList.title = category.title;
    [self.navigationController pushViewController:filteredProductList animated:YES];
}

@end
