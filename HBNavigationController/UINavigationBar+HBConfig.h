//
//  UINavigationBar+HBConfig.h
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/15.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (HBConfig)


- (UIView *)barBgView;

- (void)updateNavigationStyle:(nullable UIViewController *)target;

@end

NS_ASSUME_NONNULL_END
