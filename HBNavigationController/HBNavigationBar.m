//
//  HBNavigationBar.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/7.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "HBNavigationBar.h"

@implementation HBNavigationBar {
    
    UIView *_barBackgroundView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _backgroundAlpha = self.barBackgroundView.alpha;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateBackgroundAlpha:self.backgroundAlpha];
}

- (void)updateBackgroundAlpha:(CGFloat)alpha {
    if (!HBAlphaIsEqual(alpha, self.barBackgroundView.alpha)) {
        if (@available(iOS 11.0, *)) {
            for (UIView *view in self.barBackgroundView.subviews) {
                view.alpha = alpha;
            }
        }
        self.barBackgroundView.alpha = alpha;
    }
}

- (UIView *)barBackgroundView {
    if (!_barBackgroundView) {
        UIView *content = self.subviews.firstObject;
        _barBackgroundView = content;
    }
    return _barBackgroundView;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics {
    UIImage *current = [self backgroundImageForBarMetrics:barMetrics];
    if (!HBImageIsEqual(current, backgroundImage)) {
        [super setBackgroundImage:backgroundImage forBarMetrics:barMetrics];
    }
}

- (void)setShadowImage:(UIImage *)shadowImage {
    if (!HBImageIsEqual(self.shadowImage, shadowImage)) {
        [super setShadowImage:shadowImage];
    }
}

- (void)setAlpha:(CGFloat)alpha {
    if (!HBAlphaIsEqual(self.alpha, alpha)) {
        [super setAlpha:alpha];
    }
}

@end
