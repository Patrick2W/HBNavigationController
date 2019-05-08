//
//  MenuModel.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/8.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel

+ (instancetype)modelWithTitle:(NSString *)title toClassName:(NSString *)toClassName {
    MenuModel *model = [MenuModel new];
    model.title = title;
    model.toClassName = toClassName;
    return model;
}

@end
