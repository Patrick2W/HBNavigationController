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
    
    [self updateBarBgAlpha:tempAlpha];
}

- (UIView *)barBgView {
    return [self valueForKey:@"_backgroundView"];
}

- (void)updateNavigationStyle:(nullable UIViewController *)target {
    
    UIImage *placeholderImage = [UIImage new];
    if (target) {
        tempAlpha = target.navBarBgAlpha;
        [self updateBarBgAlpha:target.navBarBgAlpha];
        self.translucent = target.navBarTranslucent;
        if (target.navBarBgAlpha == 0) {
            [self setBackgroundImage:placeholderImage forBarMetrics:UIBarMetricsDefault];
        } else {
            [self setBackgroundImage:target.navBarBgImage forBarMetrics:UIBarMetricsDefault];
        }
    } else {
        [self updateBarBgAlpha:0];
        self.translucent = YES;
        [self setBackgroundImage:placeholderImage forBarMetrics:UIBarMetricsDefault];
    }
    [self setShadowImage:target.navBarShadowImage ?: placeholderImage];
}

- (void)updateBarBgAlpha:(CGFloat)alpha {
    UIView *barBgView = [self barBgView];
    barBgView.alpha = alpha;
}

@end
