//
//  ProductCell.h
//  Product Catalogue
//
//  Created by Boris Bügling on 11/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UICollectionViewCell

@property (nonatomic, readonly) UIImageView* coverImageView;
@property (nonatomic, readonly) UILabel* pricingLabel;
@property (nonatomic, readonly) UILabel* titleLabel;

@end
