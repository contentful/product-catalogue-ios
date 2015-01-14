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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
}

- (void)refresh {
    self.tabBarController.view.userInteractionEnabled = NO;

    [self.dataManager performSynchronizationWithSuccess:^{
        [self.dataSource performFetch];

        self.tabBarController.view.userInteractionEnabled = YES;
    } failure:^(CDAResponse *response, NSError *error) {
        if (error.code != NSURLErrorNotConnectedToInternet) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                  otherButtonTitles:nil];
            [alert show];
        }

        [self.dataSource performFetch];

        self.tabBarController.view.userInteractionEnabled = YES;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refresh)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    self.tableView.dataSource = self.dataSource;
    self.tableView.rowHeight = 70.0;

    [self.tableView registerClass:ProductCategoryCell.class forCellReuseIdentifier:NSStringFromClass([self class])];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self refresh];
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
