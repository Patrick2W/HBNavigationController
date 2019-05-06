//
//  HBNavigationController.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/6.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "HBNavigationController.h"

@interface HBNavigationController ()

@end

@implementation HBNavigationController

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%@: %@",NSStringFromSelector(_cmd), [NSDate date]);
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"%@: %@",NSStringFromSelector(_cmd), [NSDate date]);
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"%@: %@",NSStringFromSelector(_cmd), [NSDate date]);
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        NSLog(@"%@: %@",NSStringFromSelector(_cmd), [NSDate date]);
    }
    return self;
}

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass {
    self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass];
    if (self) {
        NSLog(@"%@: %@",NSStringFromSelector(_cmd), [NSDate date]);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
