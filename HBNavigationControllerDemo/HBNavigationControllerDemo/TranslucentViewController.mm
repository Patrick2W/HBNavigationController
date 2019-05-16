//
//  TranslucentViewController.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/8.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "TranslucentViewController.h"
#import "UIViewController+HBNavigation.h"
#import "UIViewController+HBNavItem.h"
#import "UIImage+Add.h"

@interface TranslucentViewController ()

@end

@implementation TranslucentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.navBarBgAlpha = 0.4;
    self.navBarBgImage = [UIImage imageWithColor:[UIColor blackColor]];
    self.navBarTranslucent = NO;
    
    self.navBarStyle = UIBarStyleBlack;
    
    self.title = @"畅爽开怀";
    
    [self setRightBarButtonItemTitle:@"不透明导航栏" andColor:[UIColor redColor] font:[UIFont systemFontOfSize:12]];
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)rightBarButtonItemDidClicked:(id)sender {
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.navBarBgImage = [UIImage imageWithColor:[UIColor colorWithWhite:0.3 alpha:0.5]];
    vc.navBarBgAlpha = 0.3;
    vc.extendedLayoutIncludesOpaqueBars = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
