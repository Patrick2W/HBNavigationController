//
//  HBNavigationBar.h
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/7.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

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

NS_ASSUME_NONNULL_BEGIN

@interface HBNavigationBar : UINavigationBar

/**
 * 导航栏背景视图Alpha
 * 默认为barBackgroundView的Alpha
 */
@property (assign, nonatomic) CGFloat backgroundAlpha;

/**
 * 导航栏背景视图
 */
@property (readonly, nonatomic) UIView *barBackgroundView;

/**
 * 分割线视图
 */
@property (readonly, nonatomic) UIImageView *barShadowImageView;

/**
 *  标题字体
 */
@property (strong, nonatomic) UIFont *titlefont;

/**
 *  标题颜色
 */
@property (strong, nonatomic) UIColor *titleColor;

@end

NS_ASSUME_NONNULL_END
