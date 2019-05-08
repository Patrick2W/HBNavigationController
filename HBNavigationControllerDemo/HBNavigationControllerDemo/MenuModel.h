//
//  MenuModel.h
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/8.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuModel : NSObject

+ (instancetype)modelWithTitle:(NSString *)title toClassName:(NSString *)toClassName;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *toClassName;

@end

NS_ASSUME_NONNULL_END
