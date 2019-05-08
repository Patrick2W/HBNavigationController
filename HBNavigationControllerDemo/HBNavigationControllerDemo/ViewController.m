//
//  ViewController.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/6.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+HBNavigation.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"第一页";
    self.navBarTitleColor = [UIColor purpleColor];
    self.navBarTitleFont = [UIFont systemFontOfSize:12];
    
    self.navBarBgImage = [self.class imageWithColor:[UIColor blueColor]];
    self.navBarBgAlpha = 0;
}

- (IBAction)pushNext:(id)sender {
    
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.navBarBgImage = [self.class imageWithColor:[UIColor redColor]];
    [self.navigationController pushViewController:vc animated:YES];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
