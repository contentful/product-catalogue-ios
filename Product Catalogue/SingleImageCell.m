//
//  SingleImageCell.m
//  Product Catalogue
//
//  Created by Boris Bügling on 22/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import "SingleImageCell.h"

@implementation SingleImageCell

@synthesize imageView = _imageView;

#pragma mark -

-(UIImageView *)imageView {
    if (_imageView) {
        return _imageView;
    }

    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    return _imageView;
}

-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    self.imageView.alpha = selected ? 0.5 : 1.0;
}

@end
