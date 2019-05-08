//
//  UIViewController+HBNavItem.h
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/8.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HBNavItem)

/**
 * 快速创建LeftBarButtonItem
 * @param image 图片
 */
- (void)setLeftBarButtonItemImage:(UIImage *)image;

/**
 * 快速创建RightBarButtonItem
 * @param image 图片
 */
- (void)setRightBarButtonItemImage:(UIImage *)image;

/**
 * 快速创建LeftBarButtonItem
 * @param title 标题
 * @param color 颜色
 * @param font 字体
 */
- (void)setLeftBarButtonItemTitle:(NSString *)title andColor:(UIColor *)color font:(UIFont *)font;

/**
 * 快速创建RightBarButtonItem
 * @param title 标题
 * @param color 颜色
 * @param font 字体
 */
- (void)setRightBarButtonItemTitle:(NSString *)title andColor:(UIColor *)color font:(UIFont *)font;

// LeftBarButtonItem被点击，可复写此方法
// 默认为返回操作
- (void)leftBarButtonItemDidClicked:(nullable id)sender;

// RightBarButtonItem被点击，可复写此方法
// do nothing
- (void)rightBarButtonItemDidClicked:(nullable id)sender;

@end

NS_ASSUME_NONNULL_END
