//
//  ViewController.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/6.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+HBNavigation.h"
#import "UIViewController+HBNavItem.h"
#import "DetailViewController.h"
#import "MenuModel.h"
#import "UIImage+Add.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"导航栏样式集合";
    self.navBarTitleColor = [UIColor whiteColor];
    self.navBarTitleFont = [UIFont systemFontOfSize:18];
    self.navBarBgImage = [UIImage imageWithColor:[UIColor brownColor]];
//    self.navBarShadowImage = [UIImage imageWithColor:[UIColor redColor]];
    
    [self prepareDataSource];
}

- (void)prepareDataSource {
    
    MenuModel *model1 = [MenuModel modelWithTitle:@"导航栏不变" toClassName:@"DetailViewController"];
    MenuModel *model2 = [MenuModel modelWithTitle:@"透明导航栏" toClassName:@"TranslucentViewController"];
    MenuModel *model3 = [MenuModel modelWithTitle:@"渐变导航栏" toClassName:@"GradientViewController"];
    MenuModel *model4 = [MenuModel modelWithTitle:@"导航栏标题样式变化" toClassName:@""];
    
    self.dataSource = @[model1, model2, model3, model4];
}

#pragma mark - UITableViewDataSource
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:10];
    
    MenuModel *model = self.dataSource[indexPath.row];
    label.text = model.title;
    
    return cell;
}

#pragma mark - UITableViewDelegate
#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuModel *model = self.dataSource[indexPath.row];
    if (model.toClassName.length > 0) {
        Class ViewControllerClass = NSClassFromString(model.toClassName);
        UIViewController *vc = [[ViewControllerClass alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
