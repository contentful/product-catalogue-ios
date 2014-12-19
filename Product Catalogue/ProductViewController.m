//
//  ProductViewController.m
//  Product Catalogue
//
//  Created by Boris Bügling on 18/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import "GalleryViewController.h"
#import "ProductViewController.h"
#import "StoryboardIdentifiers.h"

@implementation ProductViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:EmbedGalleryVCSegue]) {
        GalleryViewController* galleryVC = segue.destinationViewController;
        galleryVC.assets = self.product.image;
        galleryVC.client = self.client;
        
    }
}

@end
