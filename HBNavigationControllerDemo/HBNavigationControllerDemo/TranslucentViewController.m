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
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.navBarBgAlpha = 0;
    self.navBarTitleColor = [UIColor blackColor];
    
    self.title = @"畅爽开怀";
    
    [self setRightBarButtonItemTitle:@"不透明导航栏" andColor:[UIColor redColor] font:[UIFont systemFontOfSize:12]];
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)rightBarButtonItemDidClicked:(id)sender {
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.navBarBgImage = [UIImage imageWithColor:[UIColor blueColor]];
    vc.navBarBgAlpha = 0.5;
    vc.extendedLayoutIncludesOpaqueBars = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
