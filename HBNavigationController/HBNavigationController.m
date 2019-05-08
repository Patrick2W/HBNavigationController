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

@interface HBNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation HBNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [self initWithNavigationBarClass:[HBNavigationBar class] toolbarClass:[UIToolbar class]];
    if (self) {
        if (rootViewController) {
            self.viewControllers = @[rootViewController];
        }
    }
    return self;
}

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
    if (![self.navigationBar isKindOfClass:HBNavigationBar.class]) return;
    HBNavigationBar *navBar = (HBNavigationBar *)self.navigationBar;
    [navBar setBackgroundAlpha:toViewController.navBarBgAlpha];
    [navBar setAlpha:toViewController.navBarAlpha];
    if (HBAlphaIsEqual(toViewController.navBarBgAlpha, 0)) {
        [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [navBar setShadowImage:[UIImage new]];
    } else {
        [navBar setBackgroundImage:toViewController.navBarBgImage forBarMetrics:UIBarMetricsDefault];
        [navBar setShadowImage:toViewController.navBarShadowImage];
    }
}

- (void)updateNavBarTitleAttibutesForToViewController:(UIViewController *)toViewController {
    if (![self.navigationBar isKindOfClass:HBNavigationBar.class]) return;
    HBNavigationBar *navBar = (HBNavigationBar *)self.navigationBar;
    navBar.titlefont = toViewController.navBarTitleFont;
    navBar.titleColor = toViewController.navBarTitleColor;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    
    id <UIViewControllerTransitionCoordinator> coordinator = self.transitionCoordinator;
    if (coordinator) {
        UIViewController *from = [coordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        //UIViewController *to = [coordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController *to = viewController;
        HBNavigationBar *navBar = (HBNavigationBar *)self.navigationBar;
        
        BOOL after = NO;
        if (!HBImageIsEqual(to.navBarBgImage, from.navBarBgImage) && HBAlphaIsEqual(to.navBarBgAlpha, from.navBarBgAlpha)) {
            // 背景图片和透明度都不相同
            // 透明度过度
            navBar.backgroundAlpha = from.navBarBgAlpha / 4.0;
            
        } else if (HBAlphaIsEqual(to.navBarBgAlpha, 0)) {
            // 目标透明度为0
            after = YES;
        }
        
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            if (after) {
                navBar.backgroundAlpha = to.navBarBgAlpha;
            } else {
                [self updateNavBarForToViewController:to];
            }
            // 更新标题样式
            [self updateNavBarTitleAttibutesForToViewController:to];
            
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
            if (context.isCancelled) {
                [UIView animateWithDuration:context.transitionDuration animations:^{
                    [self updateNavBarStyleAndTitleAttributesForToViewController:from];
                }];
            } else if (after) {
                [self updateNavBarForToViewController:to];
            }
        }];
    } else {
        [self updateNavBarStyleAndTitleAttributesForToViewController:viewController];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ( self.viewControllers.count < 2 || self.topViewController.popGestureDisEnabled) {
        return NO;
    }
    return YES;
}

@end
