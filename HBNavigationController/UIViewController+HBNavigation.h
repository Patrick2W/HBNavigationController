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

// 导航栏Alpha
@property (assign, nonatomic) CGFloat navBarAlpha;
// 导航栏背景Alpha
@property (assign, nonatomic) CGFloat navBarBgAlpha;
// 导航栏分割线Alpha
//@property (assign, nonatomic) CGFloat navBarShadowAlpha;
// 导航栏图片
@property (strong, nonatomic) UIImage *navBarBgImage;
// 导航栏分割线图片
@property (strong, nonatomic) UIImage *navBarShadowImage;
// 导航栏标题字体
@property (strong, nonatomic) UIFont *navBarTitleFont;
// 导航栏标题颜色
@property (strong, nonatomic) UIColor *navBarTitleColor;

// 是否禁用滑动返回手势，默认 NO
@property (assign, nonatomic) BOOL popGestureDisEnabled;
// 当Push的时候是否自动隐藏Bottom Bar, 默认 NO
@property (assign, nonatomic) BOOL autoHideBottomBarWhenPush;

// 手动更新导航栏样式
- (void)updateNavBarStyleIfNeeded;
// 手动更新导航栏标题样式
- (void)updateNavBarTitleAttributesIfNeeded;

@end

NS_ASSUME_NONNULL_END
