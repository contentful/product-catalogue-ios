//
//  Brand.h
//  Product Catalogue
//
//  Created by Boris Bügling on 11/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <ContentfulDeliveryAPI/CDAPersistedEntry.h>

@class Asset, Product;

@interface Brand : NSManagedObject <CDAPersistedEntry>

@property (nonatomic, retain) NSString * companyDescription;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSSet *brandInverse;
@property (nonatomic, retain) Asset *logo;
@end

@interface Brand (CoreDataGeneratedAccessors)

- (void)addBrandInverseObject:(Product *)value;
- (void)removeBrandInverseObject:(Product *)value;
- (void)addBrandInverse:(NSSet *)values;
- (void)removeBrandInverse:(NSSet *)values;

@end
