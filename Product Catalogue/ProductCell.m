//
//  ProductCell.m
//  Product Catalogue
//
//  Created by Boris Bügling on 11/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <ContentfulStyle/UIFont+Contentful.h>

#import "ProductCell.h"
#import "UIView+Geometry.h"

@implementation ProductCell

@synthesize coverImageView = _coverImageView;
@synthesize pricingLabel = _pricingLabel;

-(UIImageView *)coverImageView {
    if (_coverImageView) {
        return _coverImageView;
    }

    _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 10.0, 0.0, 0.0)];
    _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    _coverImageView.width = self.width - 2 * _coverImageView.x;
    _coverImageView.height = self.height - 2 * _coverImageView.y;
    [self addSubview:_coverImageView];

    return _coverImageView;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

-(UILabel *)pricingLabel {
    if (_pricingLabel) {
        return _pricingLabel;
    }

    _pricingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 70.0, 30.0)];
    _pricingLabel.backgroundColor = [UIColor colorWithRed:216.0/255.0
                                                    green:216.0/255.0
                                                     blue:216.0/255.0
                                                    alpha:1.0];
    _pricingLabel.font = [UIFont bodyTextFont];
    _pricingLabel.textAlignment = NSTextAlignmentCenter;
    _pricingLabel.textColor = [UIColor whiteColor];
    _pricingLabel.x = self.width - _pricingLabel.width;
    _pricingLabel.y = self.height - _pricingLabel.height;
    [self addSubview:_pricingLabel];

    return _pricingLabel;
}

@end
