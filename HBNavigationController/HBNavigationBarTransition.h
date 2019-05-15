//
//  HBNavigationBarTransition.h
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/15.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+HBNavigation.h"

NS_ASSUME_NONNULL_BEGIN

@interface HBNavigationBarTransition : NSObject

//- (instancetype)init NS_UNAVAILABLE;
//+ (instancetype)new NS_UNAVAILABLE;
//- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
