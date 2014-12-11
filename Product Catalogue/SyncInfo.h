//
//  SyncInfo.h
//  Product Catalogue
//
//  Created by Boris Bügling on 11/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <ContentfulDeliveryAPI/CDAPersistedSpace.h>

@interface SyncInfo : NSManagedObject <CDAPersistedSpace>

@property (nonatomic, retain) NSDate * lastSyncTimestamp;
@property (nonatomic, retain) NSString * syncToken;

@end
