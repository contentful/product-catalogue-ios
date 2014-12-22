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
#import "HorizontalImageStripController.h"

@interface GalleryViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic) HorizontalImageStripController* imageStripController;

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
    imageVC.padding = UIEdgeInsetsMake(10.0, 30.0, 45.0, 30.0);
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
        self.delegate = self;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];

    self.imageStripController = [HorizontalImageStripController new];
    [self.view addSubview:self.imageStripController.view];

    [self.imageStripController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@140);
        make.height.equalTo(@40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(@10);
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.imageStripController.assets = self.assets;
    self.imageStripController.client = self.client;
    [self.imageStripController refresh];

    ImageViewController* imageVC = [self imageViewControllerWithIndex:0];

    if (!imageVC) {
        return;
    }

    __weak typeof(self) welf = self;
    [self setViewControllers:@[ imageVC ]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:^(BOOL finished) {
                      if (finished) {
                          [welf.imageStripController scrollToItemAtIndex:0];
                      }
                  }];
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

#pragma mark - UIPageViewControllerDelegate

-(void)pageViewController:(UIPageViewController *)pageViewController
       didFinishAnimating:(BOOL)finished
  previousViewControllers:(NSArray *)previousViewControllers
      transitionCompleted:(BOOL)completed {
    if (completed) {
        NSInteger currentIndex = [self indexOfViewController:self.viewControllers[0]];
        [self.imageStripController scrollToItemAtIndex:currentIndex];
    }
}

@end
