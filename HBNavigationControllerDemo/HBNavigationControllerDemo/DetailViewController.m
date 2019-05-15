//
//  DetailViewController.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/8.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "DetailViewController.h"
#import "UIViewController+HBNavigation.h"
#import "UIImage+Add.h"

@interface DetailViewController ()

@property (strong, nonatomic) UIButton *testButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"春雨里洗过的太阳";
    self.navBarTitleColor = [UIColor whiteColor];
//    self.navBarBgAlpha = 0.5;
    self.navBarTitleFont = [UIFont systemFontOfSize:12];
    self.navBarBgImage = [UIImage imageWithColor:[UIColor brownColor]];
    self.navBarTranslucent = NO;
    
    _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _testButton.frame = CGRectMake(0, 0, 100, 40);
    _testButton.center = self.view.center;
    _testButton.backgroundColor = [UIColor redColor];
    [_testButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.testButton];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
