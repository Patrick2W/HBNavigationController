//
//  UIViewController+HBNavigation.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/7.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "UIViewController+HBNavigation.h"
#import "HBNavigationController.h"
#import <objc/runtime.h>

@implementation UIViewController (HBNavigation)

- (void)objcSetAssociatedKey:(const void * _Nonnull)key withValue:(id _Nonnull)value {
    
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - Setter Method

- (void)setNavBarAlpha:(CGFloat)navBarAlpha {
    [self objcSetAssociatedKey:@selector(navBarAlpha) withValue:@(navBarAlpha)];
}

- (void)setNavBarBgAlpha:(CGFloat)navBarBgAlpha {
    [self objcSetAssociatedKey:@selector(navBarBgAlpha) withValue:@(navBarBgAlpha)];
}

- (void)setNavBarShadowAlpha:(CGFloat)navBarShadowAlpha {
    [self objcSetAssociatedKey:@selector(navBarShadowAlpha) withValue:@(navBarShadowAlpha)];
}

- (void)setNavBarBgImage:(UIImage *)navBarBgImage {
    [self objcSetAssociatedKey:@selector(navBarBgImage) withValue:navBarBgImage];
}

- (void)setNavBarShadowImage:(UIImage *)navBarShadowImage {
    [self objcSetAssociatedKey:@selector(navBarShadowImage) withValue:navBarShadowImage];
}

- (void)setNavBarTitleFont:(UIFont *)navBarTitleFont {
    [self objcSetAssociatedKey:@selector(navBarTitleFont) withValue:navBarTitleFont];
}

- (void)setNavBarTitleColor:(UIColor *)navBarTitleColor {
    [self objcSetAssociatedKey:@selector(navBarTitleColor) withValue:navBarTitleColor];
}

- (void)setPopGestureDisEnabled:(BOOL)popGestureDisEnabled {
    [self objcSetAssociatedKey:@selector(popGestureDisEnabled) withValue:@(popGestureDisEnabled)];
}

- (void)setAutoHideBottomBarWhenPush:(BOOL)autoHideBottomBarWhenPush {
    [self objcSetAssociatedKey:@selector(autoHideBottomBarWhenPush) withValue:@(autoHideBottomBarWhenPush)];
}

#pragma mark - Getter Method

- (CGFloat)navBarAlpha {
    id alpha = objc_getAssociatedObject(self, _cmd);
    return alpha ? [alpha floatValue] : 1.0;
}

- (CGFloat)navBarBgAlpha {
    id alpha = objc_getAssociatedObject(self, _cmd);
    return alpha ? [alpha floatValue] : 1.0;
}

- (CGFloat)navBarShadowAlpha {
    id alpha = objc_getAssociatedObject(self, _cmd);
    return alpha ? [alpha floatValue] : 1.0;
}

- (UIImage *)navBarBgImage {
    return objc_getAssociatedObject(self, _cmd);
}

- (UIImage *)navBarShadowImage {
    return objc_getAssociatedObject(self, _cmd);
}

- (UIFont *)navBarTitleFont {
    return objc_getAssociatedObject(self, _cmd);
}

- (UIColor *)navBarTitleColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (BOOL)popGestureDisEnabled {
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : NO;
}

- (BOOL)autoHideBottomBarWhenPush {
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : NO;
}

#pragma mark - Public Method

- (void)updateNavBarStyleIfNeeded {
    if ([self.navigationController isKindOfClass:[HBNavigationController class]]) {
        HBNavigationController *nav = (HBNavigationController *)self.navigationController;
        [nav updateNavBarForToViewController:self];
    }
}

- (void)updateNavBarTitleAttributesIfNeeded {
    if ([self.navigationController isKindOfClass:[HBNavigationController class]]) {
        HBNavigationController *nav = (HBNavigationController *)self.navigationController;
        [nav updateNavBarTitleAttibutesForToViewController:self];
    }
}

@end
