//
//  ContentfulDataManager.m
//  Product Catalogue
//
//  Created by Boris Bügling on 18/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <ContentfulPersistence/CoreDataManager.h>
#import <ContentfulPersistence/CoreDataFetchDataSource.h>

#import "Asset.h"
#import "Brand.h"
#import "CDASpaceSelectionViewController.h"
#import "Constants.h"
#import "ContentfulDataManager.h"
#import "Product.h"
#import "ProductCategory.h"
#import "SyncInfo.h"

NSString* const BrandContentTypeId = @"sFzTZbSuM8coEwygeUYes";
NSString* const CategoryContentTypeId = @"6XwpTaSiiI2Ak2Ww0oi6qa";
NSString* const ProductContentTypeId = @"2PqfXUJwE8qSYKuM0U6w8M";

@interface ContentfulDataManager ()

@property (nonatomic, readonly) CoreDataManager* manager;

@end

@implementation ContentfulDataManager

@synthesize manager = _manager;

-(CDAClient *)client {
    return self.manager.client;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:CDASpaceChangedNotification
                                                  object:nil];
}

-(NSFetchedResultsController*)fetchedResultsControllerForContentTypeWithIdentifier:(NSString*)contentTypeIdentifier predicate:(NSString*)predicate sortDescriptors:(NSArray*)sortDescriptors {
    NSFetchRequest* fetchRequest = [self.manager fetchRequestForEntriesOfContentTypeWithIdentifier:contentTypeIdentifier matchingPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];

    return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.manager.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(spaceChanged:)
                                                     name:CDASpaceChangedNotification
                                                   object:nil];
    }
    return self;
}

- (CoreDataManager *)manager {
    if (_manager) {
        return _manager;
    }

    _manager = [[CoreDataManager alloc] initWithClient:[[CDAClient alloc] initWithSpaceKey:[[NSUserDefaults standardUserDefaults] stringForKey:SPACE_KEY] accessToken:[[NSUserDefaults standardUserDefaults] stringForKey:ACCESS_TOKEN]] dataModelName:@"Product Catalogue"];

    _manager.classForAssets = [Asset class];
    _manager.classForSpaces = [SyncInfo class];

    [_manager setClass:Brand.class forEntriesOfContentTypeWithIdentifier:BrandContentTypeId];
    [_manager setClass:Product.class forEntriesOfContentTypeWithIdentifier:ProductContentTypeId];
    [_manager setClass:ProductCategory.class forEntriesOfContentTypeWithIdentifier:CategoryContentTypeId];

    return _manager;
}

- (void)performSynchronizationWithSuccess:(void (^)())success failure:(CDARequestFailureBlock)failure {
    [self.manager performSynchronizationWithSuccess:success failure:failure];
}

- (void)spaceChanged:(NSNotification*)note {
    [self.manager deleteAll];

    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:note.userInfo[CDAAccessTokenKey] forKey:ACCESS_TOKEN];
    [defaults setValue:note.userInfo[CDASpaceIdentifierKey] forKey:SPACE_KEY];

    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.rootViewController = [keyWindow.rootViewController.storyboard
                                    instantiateInitialViewController];
}

@end
