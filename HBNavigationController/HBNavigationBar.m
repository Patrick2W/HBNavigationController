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
    UIImageView *_barShadowImageView;
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

- (UIImageView *)barShadowImageView {
    if (!_barShadowImageView) {
        NSArray *sub = self.barBackgroundView.subviews;
        if (sub.count > 1) {
            _barShadowImageView = sub[1];
        }
    }
    return _barShadowImageView;
}

- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha {
    if (backgroundAlpha < 0) return;
    _backgroundAlpha = backgroundAlpha;
    [self updateBackgroundAlpha:backgroundAlpha];
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
    if (alpha < 0) return;
    if (!HBAlphaIsEqual(self.alpha, alpha)) {
        [super setAlpha:alpha];
    }
}

- (void)setTitlefont:(UIFont *)titlefont {
    _titlefont = titlefont;
    [self updateTitleTextAttributes];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self updateTitleTextAttributes];
}

- (void)updateTitleTextAttributes {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.titleTextAttributes) {
        [dic addEntriesFromDictionary:self.titleTextAttributes];
    }
    if (self.titlefont) {
        [dic setObject:self.titlefont forKey:NSFontAttributeName];
    }
    if (self.titleColor) {
        [dic setObject:self.titleColor forKey:NSForegroundColorAttributeName];
    }
    if (dic.count > 0) {
        self.titleTextAttributes = dic;
    }
}

@end
