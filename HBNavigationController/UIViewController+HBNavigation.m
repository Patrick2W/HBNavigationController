//
//  UIViewController+HBNavigation.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/7.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "UIViewController+HBNavigation.h"
#import "UINavigationBar+HBConfig.h"
#import <objc/runtime.h>

@implementation UIViewController (HBNavigation)

- (void)objcSetAssociatedKey:(const void * _Nonnull)key withValue:(id _Nonnull)value {
    
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Setter Method

- (void)setNavBarStyle:(UIBarStyle)navBarStyle {
    [self objcSetAssociatedKey:@selector(navBarStyle) withValue:@(navBarStyle)];
}

- (void)setNavBarBgAlpha:(CGFloat)navBarBgAlpha {
    [self objcSetAssociatedKey:@selector(navBarBgAlpha) withValue:@(navBarBgAlpha)];
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

- (void)setNavBarTranslucent:(BOOL)navBarTranslucent {
    [self objcSetAssociatedKey:@selector(navBarTranslucent) withValue:@(navBarTranslucent)];
}

- (void)setPopGestureDisEnabled:(BOOL)popGestureDisEnabled {
    [self objcSetAssociatedKey:@selector(popGestureDisEnabled) withValue:@(popGestureDisEnabled)];
}

- (void)setAutoHideBottomBarWhenPush:(BOOL)autoHideBottomBarWhenPush {
    [self objcSetAssociatedKey:@selector(autoHideBottomBarWhenPush) withValue:@(autoHideBottomBarWhenPush)];
}

#pragma mark - Getter Method

- (UIBarStyle)navBarStyle {
    id style = objc_getAssociatedObject(self, _cmd);
    return style ? [style integerValue] : UIBarStyleDefault;
}

- (CGFloat)navBarBgAlpha {
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

- (BOOL)navBarTranslucent {
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : YES;
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
    [self.navigationController.navigationBar configBarStyleWithViewController:self];
}

- (void)updateNavBarTitleAttributesIfNeeded {
    [self.navigationController.navigationBar configTitleStyleWithViewController:self];
}

@end
