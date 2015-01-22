//
//  CMAProductCatalogueVerifier.m
//  Product Catalogue
//
//  Created by Boris Bügling on 22/01/15.
//  Copyright (c) 2015 Boris Bügling. All rights reserved.
//

#import <ContentfulManagementAPI/ContentfulManagementAPI.h>

#import "CMAProductCatalogueVerifier.h"
#import "ContentfulDataManager.h"

@implementation CMAProductCatalogueVerifier

-(void)verifySpaceWithResult:(CMASpaceVerificationResult)result {
    NSParameterAssert(result);

    [super verifySpaceWithResult:^(BOOL verified, NSError *error) {
        if (verified) {
            [self.space fetchContentTypesWithSuccess:^(CDAResponse *response, CDAArray *array) {
                NSUInteger found = 0;

                for (CMAContentType* contentType in array.items) {
                    if ([@[ProductContentTypeId,
                           BrandContentTypeId,
                           CategoryContentTypeId] containsObject:contentType.identifier]) {
                        found++;
                    }
                }

                result(found == 3, nil);
            } failure:^(CDAResponse *response, NSError *error) {
                result(NO, error);
            }];
        } else {
            result(verified, error);
        }
    }];
}

@end
