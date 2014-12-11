//
//  Asset.h
//  Product Catalogue
//
//  Created by Boris Bügling on 11/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <ContentfulDeliveryAPI/CDAPersistedAsset.h>

@class Brand, Product, ProductCategory;

@interface Asset : NSManagedObject <CDAPersistedAsset>

@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * internetMediaType;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSSet *BrandInverse;
@property (nonatomic, retain) NSSet *CategoryInverse;
@property (nonatomic, retain) NSSet *ProductInverse;
@end

@interface Asset (CoreDataGeneratedAccessors)

- (void)addBrandInverseObject:(Brand *)value;
- (void)removeBrandInverseObject:(Brand *)value;
- (void)addBrandInverse:(NSSet *)values;
- (void)removeBrandInverse:(NSSet *)values;

- (void)addCategoryInverseObject:(ProductCategory *)value;
- (void)removeCategoryInverseObject:(ProductCategory *)value;
- (void)addCategoryInverse:(NSSet *)values;
- (void)removeCategoryInverse:(NSSet *)values;

- (void)addProductInverseObject:(Product *)value;
- (void)removeProductInverseObject:(Product *)value;
- (void)addProductInverse:(NSSet *)values;
- (void)removeProductInverse:(NSSet *)values;

@end
