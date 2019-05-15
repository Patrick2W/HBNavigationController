//
//  HBNavigationController.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/6.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "HBNavigationController.h"
#import "UIViewController+HBNavigation.h"
#import "HBNavigationBar.h"
#import "HBNavigationBarTransition.h"

@interface HBNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate, UINavigationBarDelegate>

@property (strong, nonatomic) HBNavigationBarTransition *barTransition;

@end

@implementation HBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController preferredStatusBarStyle];
}

#pragma mark - Update Method

- (void)updateNavBarStyleAndTitleAttributesForToViewController:(UIViewController *)toViewController {
    [self updateNavBarForToViewController:toViewController];
    [self updateNavBarTitleAttibutesForToViewController:toViewController];
}

- (void)updateNavBarForToViewController:(UIViewController *)toViewController {
}

- (void)updateNavBarTitleAttibutesForToViewController:(UIViewController *)toViewController {
    /*
    if (![self.navigationBar isKindOfClass:HBNavigationBar.class]) return;
    HBNavigationBar *navBar = (HBNavigationBar *)self.navigationBar;
    navBar.titlefont = toViewController.navBarTitleFont;
    navBar.titleColor = toViewController.navBarTitleColor;
     */
}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {
    
    return UIBarPositionTopAttached;
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

- (void)interactivePopGestureRecognizerDidTouchHandler {
    id <UIViewControllerTransitionCoordinator> coordinator = self.transitionCoordinator;
    if (coordinator) {
        // 滑动返回比例
        //NSLog(@"percentComplete: %.2f", coordinator.percentComplete);
        //NSLog(@"completionVelocity: %.2f", coordinator.completionVelocity);
    }
}

- (HBNavigationBarTransition *)barTransition {
    if (!_barTransition) {
        _barTransition = [[HBNavigationBarTransition alloc] init];
    }
    return _barTransition;
}

@end
