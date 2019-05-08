//
//  GradientViewController.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/8.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "GradientViewController.h"
#import "UIViewController+HBNavigation.h"
#import "UIImage+Add.h"

@interface GradientViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation GradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"心中的日月";
    self.navBarTitleColor = [UIColor blackColor];
    
    self.navBarBgImage = [UIImage imageWithColor:[UIColor purpleColor]];
    self.navBarBgAlpha = 0;
    
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor yellowColor];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 0;
    }
    return _tableView;
}


#pragma mark - UITableViewDataSource
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat base = 300;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        self.navBarBgAlpha = 0;
    } else if (offsetY <= base) {
        self.navBarBgAlpha = offsetY / base;
    } else {
        self.navBarBgAlpha = 1;
    }
    [self updateNavBarStyleIfNeeded];
}



@end
