//
//  HBNavigationController.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/6.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "HBNavigationController.h"
#import "UIViewController+HBNavigation.h"
#import "HBNavigationBarTransition.h"

@interface HBNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) HBNavigationBarTransition *barTransition;

@end

@implementation HBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - Super Method

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0 && viewController.autoHideBottomBarWhenPush) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    [self.barTransition navigationController:navigationController
                      willShowViewController:viewController
                                    animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    [self.barTransition navigationController:navigationController
                       didShowViewController:viewController
                                    animated:animated];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ( self.viewControllers.count < 2 || self.topViewController.popGestureDisEnabled) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Lazy Load

- (HBNavigationBarTransition *)barTransition {
    if (!_barTransition) {
        _barTransition = [[HBNavigationBarTransition alloc] init];
    }
    return _barTransition;
}

@end
