//
//  DetailViewController.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/8.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "DetailViewController.h"
#import "UIViewController+HBNavigation.h"

@interface DetailViewController ()

@property (strong, nonatomic) UIButton *testButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navBarBgImage = [self.class imageWithColor:[UIColor blueColor]];
    //    vc.navBarBgImage = [self.class imageWithColor:[UIColor redColor]];
//    self.navBarBgAlpha = 0;
    self.title = @"第二页";
    self.navBarTitleColor = [UIColor blackColor];
    self.navBarTitleFont = [UIFont systemFontOfSize:18];
    
    
    
    _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _testButton.frame = CGRectMake(0, 0, 100, 40);
    _testButton.center = self.view.center;
    _testButton.backgroundColor = [UIColor redColor];
    [_testButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.testButton];
}

- (void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
