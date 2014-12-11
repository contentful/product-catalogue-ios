//
//  ProductCategory.h
//  Product Catalogue
//
//  Created by Boris Bügling on 11/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <ContentfulDeliveryAPI/CDAPersistedEntry.h>

@class Asset, Product;

@interface ProductCategory : NSManagedObject <CDAPersistedEntry>

@property (nonatomic, retain) NSString * categoryDescription;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *categoriesInverse;
@property (nonatomic, retain) Asset *icon;
@end

@interface ProductCategory (CoreDataGeneratedAccessors)

- (void)addCategoriesInverseObject:(Product *)value;
- (void)removeCategoriesInverseObject:(Product *)value;
- (void)addCategoriesInverse:(NSSet *)values;
- (void)removeCategoriesInverse:(NSSet *)values;

@end
