//
//  Product.h
//  Product Catalogue
//
//  Created by Boris Bügling on 11/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <ContentfulDeliveryAPI/CDAPersistedEntry.h>

@class Asset, Brand, ProductCategory;

@interface Product : NSManagedObject <CDAPersistedEntry>

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * productDescription;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSString * sizetypecolor;
@property (nonatomic, retain) NSString * sku;
@property (nonatomic, retain) Brand *brand;
@property (nonatomic, retain) NSOrderedSet *categories;
@property (nonatomic, retain) NSOrderedSet *image;
@end

@interface Product (CoreDataGeneratedAccessors)

- (void)insertObject:(ProductCategory *)value inCategoriesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCategoriesAtIndex:(NSUInteger)idx;
- (void)insertCategories:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCategoriesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCategoriesAtIndex:(NSUInteger)idx withObject:(ProductCategory *)value;
- (void)replaceCategoriesAtIndexes:(NSIndexSet *)indexes withCategories:(NSArray *)values;
- (void)addCategoriesObject:(ProductCategory *)value;
- (void)removeCategoriesObject:(ProductCategory *)value;
- (void)addCategories:(NSOrderedSet *)values;
- (void)removeCategories:(NSOrderedSet *)values;
- (void)insertObject:(Asset *)value inImageAtIndex:(NSUInteger)idx;
- (void)removeObjectFromImageAtIndex:(NSUInteger)idx;
- (void)insertImage:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeImageAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInImageAtIndex:(NSUInteger)idx withObject:(Asset *)value;
- (void)replaceImageAtIndexes:(NSIndexSet *)indexes withImage:(NSArray *)values;
- (void)addImageObject:(Asset *)value;
- (void)removeImageObject:(Asset *)value;
- (void)addImage:(NSOrderedSet *)values;
- (void)removeImage:(NSOrderedSet *)values;
@end
