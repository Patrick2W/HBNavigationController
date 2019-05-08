//
//  HBNavigationController.h
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/6.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBNavigationController : UINavigationController

/**
 *  更新导航栏样式
 */
- (void)updateNavBarForToViewController:(UIViewController *)toViewController;

/**
 *  更新导航栏标题样式
 */
- (void)updateNavBarTitleAttibutesForToViewController:(UIViewController *)toViewController;

@end

NS_ASSUME_NONNULL_END
