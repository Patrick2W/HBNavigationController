//
//  HBNavigationController.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/6.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "HBNavigationController.h"
#import "UIViewController+HBNavigation.h"
#import "HBNavigationBar.h"

@interface HBNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation HBNavigationController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [self initWithNavigationBarClass:[HBNavigationBar class] toolbarClass:[UIToolbar class]];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    //self.interactivePopGestureRecognizer.delegate = self;
    
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    
}


#pragma mark - UIGestureRecognizerDelegate

@end
