//
//  UIViewController+HBNavItem.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/8.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "UIViewController+HBNavItem.h"

@implementation UIViewController (HBNavItem)

- (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image action:(SEL)action {
    UIImage *img = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:action];
    return item;
}

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title andColor:(UIColor *)color font:(UIFont *)font action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.frame = CGRectMake(0, 0, MAX(44, button.frame.size.width), 44);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

- (void)setLeftBarButtonItemImage:(UIImage *)image {
    SEL action = @selector(leftBarButtonItemDidClicked:);
    UIBarButtonItem *leftItem = [self barButtonItemWithImage:image action:action];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)setRightBarButtonItemImage:(UIImage *)image {
    SEL action = @selector(rightBarButtonItemDidClicked:);
    UIBarButtonItem *rightItem = [self barButtonItemWithImage:image action:action];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setLeftBarButtonItemTitle:(NSString *)title andColor:(UIColor *)color font:(UIFont *)font {
    SEL action = @selector(leftBarButtonItemDidClicked:);
    UIBarButtonItem *leftItem = [self barButtonItemWithTitle:title
                                                    andColor:color
                                                        font:font
                                                      action:action];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)setRightBarButtonItemTitle:(NSString *)title andColor:(UIColor *)color font:(UIFont *)font {
    SEL action = @selector(rightBarButtonItemDidClicked:);
    UIBarButtonItem *rightItem = [self barButtonItemWithTitle:title
                                                     andColor:color
                                                         font:font
                                                       action:action];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)leftBarButtonItemDidClicked:(nullable id)sender {
    UIViewController *popViewController = [self.navigationController popViewControllerAnimated:YES];
    if (!popViewController && self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)rightBarButtonItemDidClicked:(nullable id)sender {
    
}

@end
