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

@interface HBNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate, UINavigationBarDelegate>

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
    
    self.navigationBar.translucent = NO;
    
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
    [navBar setAlpha:toViewController.navBarAlpha];
    if (HBAlphaIsEqual(toViewController.navBarBgAlpha, 0)) {
        [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [navBar setShadowImage:[UIImage new]];
    } else {
        [navBar setBackgroundImage:toViewController.navBarBgImage forBarMetrics:UIBarMetricsDefault];
        [navBar setShadowImage:toViewController.navBarShadowImage];
    }
    [navBar setBackgroundAlpha:toViewController.navBarBgAlpha];
}

- (void)updateNavBarTitleAttibutesForToViewController:(UIViewController *)toViewController {
    if (![self.navigationBar isKindOfClass:HBNavigationBar.class]) return;
    HBNavigationBar *navBar = (HBNavigationBar *)self.navigationBar;
    navBar.titlefont = toViewController.navBarTitleFont;
    navBar.titleColor = toViewController.navBarTitleColor;
}

- (UIView *)AddFakeViewOnViewController:(UIViewController *)viewController {
    HBNavigationBar *navBar = (HBNavigationBar *)self.navigationBar;
    
    CGRect rect = [self.view convertRect:navBar.frame toView:viewController.view];
    
    
    HBNavigationBar *fakeBar = [[HBNavigationBar alloc] initWithFrame:rect];
    fakeBar.barStyle = navBar.barStyle;
    fakeBar.delegate = self;
    fakeBar.translucent = navBar.translucent;
    [fakeBar setBackgroundImage:viewController.navBarBgImage forBarMetrics:UIBarMetricsDefault];
    fakeBar.backgroundAlpha = viewController.navBarBgAlpha;
    
    [viewController.view addSubview:fakeBar];
    
    
    return fakeBar;
}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {
    
    return UIBarPositionTopAttached;
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
        
        BOOL same = HBImageIsEqual(from.navBarBgImage, to.navBarBgImage) && HBAlphaIsEqual(from.navBarBgAlpha, to.navBarBgAlpha);
        
        if (!same) {
            __block UIView *fromFake, *toFake;
            HBNavigationBar *navBar = (HBNavigationBar *)self.navigationBar;
            navBar.backgroundAlpha = 0;
            [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            self.navigationBar.translucent = YES;
//            self.navigationBar.barStyle = UIBarStyleBlack;
            
            [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                
                [UIView setAnimationsEnabled:NO];
                fromFake = [self AddFakeViewOnViewController:from];
                toFake = [self AddFakeViewOnViewController:to];
                [UIView setAnimationsEnabled:YES];
                
                [self updateNavBarTitleAttibutesForToViewController:to];
                
            } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                
                [fromFake removeFromSuperview];
                
                
                [toFake removeFromSuperview];
                
                self.navigationBar.translucent = NO;
                
                if (context.isCancelled) {
                    [self updateNavBarStyleAndTitleAttributesForToViewController:from];
                } else {
                    [self updateNavBarStyleAndTitleAttributesForToViewController:to];
                }
                
            }];
        } else {
            [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                [self updateNavBarTitleAttibutesForToViewController:to];
            } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                if (context.isCancelled) {
                    [self updateNavBarStyleAndTitleAttributesForToViewController:from];
                } else {
                    //[self updateNavBarStyleAndTitleAttributesForToViewController:to];
                }
            }];
        }
        
    } else {
        [self updateNavBarStyleAndTitleAttributesForToViewController:viewController];
    }
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    [self updateNavBarStyleAndTitleAttributesForToViewController:viewController];
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

@end
