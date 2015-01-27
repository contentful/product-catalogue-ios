//
//  UIScrollingViewController.m
//  Product Catalogue
//
//  Created by Boris Bügling on 27/01/15.
//  Copyright (c) 2015 Boris Bügling. All rights reserved.
//

#import "UIScrollingViewController.h"

@interface UIScrollingViewController ()

@end

#pragma mark -

@implementation UIScrollingViewController

-(CGFloat)contentHeight {
    return self.view.frame.size.height;
}

-(void)loadView {
    [super loadView];

    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:self.view];

    self.view = scrollView;
}

-(void)updateContentSizeToHeight:(CGFloat)height {
    UIView* contentView = self.view.subviews[0];
    contentView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, height);
    ((UIScrollView*)self.view).contentSize = contentView.frame.size;
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    [self updateContentSizeToHeight:self.contentHeight];

    [self.view layoutIfNeeded];
}

@end
