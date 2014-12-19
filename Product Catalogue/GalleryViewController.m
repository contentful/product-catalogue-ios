//
//  GalleryViewController.m
//  Product Catalogue
//
//  Created by Boris Bügling on 18/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "GalleryViewController.h"
#import "ImageViewController.h"

@interface GalleryViewController () <UIPageViewControllerDataSource>

@end

#pragma mark -

@implementation GalleryViewController

-(ImageViewController*)imageViewControllerWithIndex:(NSInteger)index {
    if (index < 0 || index >= self.assets.count) {
        return nil;
    }

    ImageViewController* imageVC = [ImageViewController new];
    imageVC.asset = self.assets[index];
    imageVC.client = self.client;
    return imageVC;
}

-(NSInteger)indexOfViewController:(UIViewController*)viewController {
    ImageViewController* imageVC = (ImageViewController*)viewController;
    return [self.assets indexOfObject:imageVC.asset];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                    navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                  options:nil];
    if (self) {
        self.dataSource = self;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    ImageViewController* imageVC = [self imageViewControllerWithIndex:0];

    if (!imageVC) {
        return;
    }

    [self setViewControllers:@[ imageVC ]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
}

#pragma mark - UIPageViewControllerDataSource

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger currentIndex = [self indexOfViewController:viewController];
    return [self imageViewControllerWithIndex:currentIndex + 1];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
     viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger currentIndex = [self indexOfViewController:viewController];
    return [self imageViewControllerWithIndex:currentIndex - 1];
}

@end
