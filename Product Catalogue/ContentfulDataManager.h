//
//  ContentfulDataManager.h
//  Product Catalogue
//
//  Created by Boris Bügling on 18/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <ContentfulDeliveryAPI/ContentfulDeliveryAPI.h>
#import <Foundation/Foundation.h>

extern NSString* const BrandContentTypeId;
extern NSString* const CategoryContentTypeId;
extern NSString* const ProductContentTypeId;

@interface ContentfulDataManager : NSObject

@property (nonatomic, readonly) CDAClient* client;

-(NSFetchedResultsController*)fetchedResultsControllerForContentTypeWithIdentifier:(NSString*)contentTypeIdentifier sortDescriptors:(NSArray*)sortDescriptors;
-(void)performSynchronizationWithSuccess:(void (^)())success
                                 failure:(CDARequestFailureBlock)failure;

@end
