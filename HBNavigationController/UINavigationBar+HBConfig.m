//
//  UINavigationBar+HBConfig.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/15.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "UINavigationBar+HBConfig.h"
#import "UIViewController+HBNavigation.h"
#import <objc/runtime.h>

CGFloat tempAlpha = 0.7;


NS_INLINE void HBExchageSelector(Class eclass, SEL orginalSelector, SEL newSelector) {
    Method originalMethod = class_getInstanceMethod(eclass, orginalSelector);
    Method newMethod = class_getInstanceMethod(eclass, newSelector);
    
    BOOL result = class_addMethod(eclass, orginalSelector,
                                  method_getImplementation(originalMethod),
                                  method_getTypeEncoding(originalMethod));
    if (result) {
        class_replaceMethod(eclass, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

@implementation UINavigationBar (HBConfig)

+ (void)load {
    HBExchageSelector(self, @selector(layoutSubviews), @selector(hb_layoutSubviews));
}

- (void)hb_layoutSubviews {
    
    [self hb_layoutSubviews];
    
    [self updateBarBgAlpha:self.barBgAlpha];
}

- (void)updateBarBgAlpha:(CGFloat)alpha {
    UIView *bgView = [self barBgView];
    if (!HBAlphaIsEqual(bgView.alpha, alpha)) {
        bgView.alpha = alpha;
    }
}

- (void)updateBarBgImage:(UIImage *)image {
    UIImage *current = [self backgroundImageForBarMetrics:UIBarMetricsDefault];
    if (HBImageIsEqual(current, image) || !image) return;
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)updateBarShadowImage:(UIImage *)image {
    if (HBImageIsEqual(image, self.shadowImage) || !image) return;
    self.shadowImage = image;
}

- (void)updateTitleTextAttributes {
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionary];
    if (self.titleTextAttributes) {
        [titleTextAttributes addEntriesFromDictionary:self.titleTextAttributes];
    }
    if (self.titlefont) {
        [titleTextAttributes setObject:self.titlefont forKey:NSFontAttributeName];
    }
    if (self.titleColor) {
        [titleTextAttributes setObject:self.titleColor forKey:NSForegroundColorAttributeName];
    }
    if (titleTextAttributes.count > 0) {
        self.titleTextAttributes = titleTextAttributes;
    }
}

- (UIView *)barBgView {
    return [self valueForKey:@"_backgroundView"];
}

- (UIFont *)titlefont {
    return objc_getAssociatedObject(self, _cmd);
}

- (UIColor *)titleColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (CGFloat)barBgAlpha {
    id alpha = objc_getAssociatedObject(self, _cmd);
    return alpha ? [alpha floatValue] : 1.0;
}

- (void)setTitlefont:(UIFont *)titlefont {
    objc_setAssociatedObject(self, @selector(titlefont), titlefont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateTitleTextAttributes];
}

- (void)setTitleColor:(UIColor *)titleColor {
    objc_setAssociatedObject(self, @selector(titleColor), titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateTitleTextAttributes];
}

- (void)setBarBgAlpha:(CGFloat)barBgAlpha {
    objc_setAssociatedObject(self, @selector(barBgAlpha), @(barBgAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateBarBgAlpha:barBgAlpha];
}

#pragma mark - Public Method

- (void)configBarStyleWithViewController:(UIViewController *)target {
    if (!target) return;
    
    self.translucent = target.navBarTranslucent;
    self.barBgAlpha = target.navBarBgAlpha;
    if (HBAlphaIsEqual(target.navBarBgAlpha, 0)) {
        [self updateBarBgImage:[UIImage new]];
    } else {
        [self updateBarBgImage:target.navBarBgImage];
    }
    [self updateBarShadowImage:target.navBarShadowImage];
}

- (void)configTitleStyleWithViewController:(UIViewController *)target {
    if (!target) return;
    
    self.titlefont = target.navBarTitleFont;
    self.titleColor = target.navBarTitleColor;
    self.barStyle = target.navBarStyle;
}

- (void)configFakeStyle {
    self.translucent = YES;
    [self updateBarBgImage:[UIImage new]];
}

@end
