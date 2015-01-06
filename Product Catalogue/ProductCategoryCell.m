//
//  ProductCategoryCell.m
//  Product Catalogue
//
//  Created by Boris Bügling on 06/01/15.
//  Copyright (c) 2015 Boris Bügling. All rights reserved.
//

#import <ContentfulStyle/UIColor+Contentful.h>
#import <ContentfulStyle/UIFont+Contentful.h>

#import "ProductCategoryCell.h"
#import "UIView+Geometry.h"

static const CGFloat TextLabelHeight = 30.0;

@implementation ProductCategoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        self.detailTextLabel.font = [UIFont tabTitleFont];
        self.detailTextLabel.textColor = [UIColor contentfulDeactivatedColor];
        
        self.textLabel.font = [UIFont bodyTextFont];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];

    self.textLabel.y += self.textLabel.height - TextLabelHeight;
    self.textLabel.height = TextLabelHeight;
}

@end
