//
//  ProductCell.m
//  Product Catalogue
//
//  Created by Boris Bügling on 11/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <ContentfulStyle/UIFont+Contentful.h>

#import "ProductCell.h"

@implementation ProductCell

@synthesize pricingLabel = _pricingLabel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.separatorInset = UIEdgeInsetsZero;
        self.textLabel.font = [UIFont bodyTextFont];
        self.textLabel.numberOfLines = 2;
    }
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

    [self.contentView addSubview:_pricingLabel];

    return _pricingLabel;
}

-(void)layoutSubviews {
    [super layoutSubviews];

    self.imageView.frame = CGRectMake(10.0, 10.0,
                                      self.frame.size.height - 20.0, self.frame.size.height - 20.0);

    CGRect frame = self.pricingLabel.frame;
    frame.origin.x = CGRectGetMaxX(self.imageView.frame) + 10.0;
    frame.origin.y = CGRectGetMaxY(self.imageView.frame) - frame.size.height;
    self.pricingLabel.frame = frame;

    frame = self.textLabel.frame;
    frame.origin.x = self.pricingLabel.frame.origin.x;
    frame.origin.y = self.imageView.frame.origin.y + 20.0;
    frame.size.width = self.frame.size.width - frame.origin.x - 20.0;
    frame.size.height = self.pricingLabel.frame.origin.y - frame.origin.y - 10.0;
    self.textLabel.frame = frame;

    [self.textLabel sizeToFit];
}

@end
