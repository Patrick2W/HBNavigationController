//
//  UINavigationBar+HBConfig.h
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/15.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

NS_INLINE BOOL HBAlphaIsEqual(CGFloat alpha1, CGFloat alpha2) {
    NSInteger ap1 = alpha1 * 10000;
    NSInteger ap2 = alpha2 * 10000;
    return ap1 == ap2;
}

NS_INLINE BOOL HBImageIsEqual(UIImage *image1, UIImage *image2) {
    if (image1 == image2) return YES;
    if (image1 && image2) {
        NSData *data1 = UIImagePNGRepresentation(image1);
        NSData *data2 = UIImagePNGRepresentation(image2);
        return [data1 isEqual:data2];
    }
    return NO;
}

@interface UINavigationBar (HBConfig)

/**
 * background view
 */
- (UIView *)barBgView;

/**
 *  标题字体
 */
@property (strong, nonatomic) UIFont *titlefont;

/**
 *  标题颜色
 */
@property (strong, nonatomic) UIColor *titleColor;

/**
 *  背景透明度
 */
@property (assign, nonatomic) CGFloat barBgAlpha;

/**
 *  配置导航栏样式
 */
- (void)configBarStyleWithViewController:(UIViewController *)target;

/**
 *  配置标题样式
 */
- (void)configTitleStyleWithViewController:(UIViewController *)target;

/**
 *  过度样式
 */
- (void)configFakeStyle;

@end

NS_ASSUME_NONNULL_END
