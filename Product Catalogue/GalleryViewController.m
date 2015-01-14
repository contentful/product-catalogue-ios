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

@property (nonatomic) UIButton* leftButton;
@property (nonatomic) HorizontalImageStripController* imageStripController;
@property (nonatomic) UIButton* rightButton;

@end

#pragma mark -

@implementation GalleryViewController

-(UIButton*)buildButtonUsingAdditionalConstraints:(void(^)(MASConstraintMaker* make))block {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"right-arrow"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(13.0, 10.0, 14.0, 10.0)];
    [self.view addSubview:button];

    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@31);
        make.height.equalTo(@44);
        make.centerY.equalTo(self.view.mas_centerY);

        if (block) {
            block(make);
        }
    }];

    return button;
}

-(ImageViewController*)imageViewControllerWithIndex:(NSInteger)index {
    if (index < 0 || index >= self.assets.count) {
        return nil;
    }

    ImageViewController* imageVC = [ImageViewController new];
    imageVC.asset = self.assets[index];
    imageVC.client = self.client;
    imageVC.padding = UIEdgeInsetsMake(10.0, 36.0, 45.0, 36.0);
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

-(void)updateCurrentIndex:(NSInteger)currentIndex {
    [self.imageStripController scrollToItemAtIndex:currentIndex];

    self.leftButton.enabled = currentIndex > 0;
    self.leftButton.alpha = self.leftButton.enabled ? 1.0 : 0.5;

    self.rightButton.enabled = currentIndex < self.assets.count - 1;
    self.rightButton.alpha = self.rightButton.enabled ? 1.0 : 0.5;
}

-(void)viewDidLoad{
    [super viewDidLoad];

    self.imageStripController = [HorizontalImageStripController new];
    [self.view addSubview:self.imageStripController.view];

    [self.imageStripController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@140);
        make.height.equalTo(@40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(@0);
    }];

    self.leftButton = [self buildButtonUsingAdditionalConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
    }];
    self.leftButton.transform = CGAffineTransformMakeRotation(M_PI);
    [self.leftButton addTarget:self action:@selector(scrollLeft:) forControlEvents:UIControlEventTouchUpInside];

    self.rightButton = [self buildButtonUsingAdditionalConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
    }];
    [self.rightButton addTarget:self action:@selector(scrollRight:) forControlEvents:UIControlEventTouchUpInside];
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
                          [welf updateCurrentIndex:0];
                      }
                  }];
}

#pragma mark - Actions

-(void)scrollToViewController:(UIViewController*)viewController
                    direction:(UIPageViewControllerNavigationDirection)direction {
    __weak typeof(self) welf = self;
    [self setViewControllers:@[ viewController ]
                   direction:direction
                    animated:YES
                  completion:^(BOOL finished) {
                      __strong typeof(self) sself = welf;

                      NSInteger currentIndex = [sself indexOfViewController:viewController];
                      [sself updateCurrentIndex:currentIndex];
                  }];
}

-(void)scrollLeft:(UIButton*)button {
    [self scrollToViewController:[self pageViewController:self viewControllerBeforeViewController:self.viewControllers[0]] direction:UIPageViewControllerNavigationDirectionReverse];
}


-(void)scrollRight:(UIButton*)button {
    [self scrollToViewController:[self pageViewController:self viewControllerAfterViewController:self.viewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward];
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
        [self updateCurrentIndex:currentIndex];
    }
}

@end
