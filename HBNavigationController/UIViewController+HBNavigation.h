//
//  UIViewController+HBNavigation.h
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/7.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HBNavigation)

@property (assign, nonatomic) UIBarStyle navBarStyle;
// 导航栏背景Alpha
@property (assign, nonatomic) CGFloat navBarBgAlpha;
// 导航栏图片
@property (strong, nonatomic) UIImage *navBarBgImage;
// 导航栏分割线图片
@property (strong, nonatomic) UIImage *navBarShadowImage;
// 导航栏标题字体
@property (strong, nonatomic) UIFont *navBarTitleFont;
// 导航栏标题颜色
@property (strong, nonatomic) UIColor *navBarTitleColor;
// 导航栏半透明
@property (assign, nonatomic) BOOL navBarTranslucent;

// 是否禁用滑动返回手势，默认 NO
@property (assign, nonatomic) BOOL popGestureDisEnabled;
// 当Push的时候是否自动隐藏Bottom Bar, 默认 NO
@property (assign, nonatomic) BOOL autoHideBottomBarWhenPush;

// 手动更新导航栏样式
- (void)updateNavBarStyleIfNeeded;

@end

NS_ASSUME_NONNULL_END
