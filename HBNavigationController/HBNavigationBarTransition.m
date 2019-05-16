//
//  HBNavigationBarTransition.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/15.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "HBNavigationBarTransition.h"
#import "UINavigationBar+HBConfig.h"
#import "NSObject+HBKVOBlock.h"


@interface _HBFakeNavgationBar : UIToolbar<UIToolbarDelegate>

@property (assign, nonatomic) CGFloat barBgAlpha;

@end

@implementation _HBFakeNavgationBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self barBgView].alpha = self.barBgAlpha;
}

- (UIView *)barBgView {
    return [self valueForKey:@"_backgroundView"];
}

- (void)updateBarWithViewController:(UIViewController *)viewController {
    self.barBgAlpha = viewController.navBarBgAlpha;
    self.translucent = viewController.navBarTranslucent;
    UIImage *placeholder = [UIImage new];
    if (!HBAlphaIsEqual(0, viewController.navBarBgAlpha)) {
        placeholder = viewController.navBarBgImage;
    }
    [self setBackgroundImage:placeholder
          forToolbarPosition:UIBarPositionAny
                  barMetrics:UIBarMetricsDefault];
}

- (void)setBarBgAlpha:(CGFloat)barBgAlpha {
    _barBgAlpha = barBgAlpha;
    [self barBgView].alpha = barBgAlpha;
}

#pragma mark - UIToolbarDelegate

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTop;
}

@end


@implementation HBNavigationBarTransition

- (void)navBar:(UINavigationBar *)navBar defaultStyle:(UIViewController *)target {
    [navBar configBarStyleWithViewController:target];
    [navBar configTitleStyleWithViewController:target];
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    id <UIViewControllerTransitionCoordinator> coordinator = navigationController.transitionCoordinator;
    UINavigationBar *navBar = navigationController.navigationBar;
    if (coordinator) {
        UIViewController *from = [coordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *to = viewController;
        BOOL needFake = NO;
        if (!HBImageIsEqual(from.navBarBgImage, to.navBarBgImage)) needFake = YES;
        if (!HBAlphaIsEqual(from.navBarBgAlpha, to.navBarBgAlpha)) needFake = YES;
        if (![@(from.navBarTranslucent) isEqualToNumber:@(to.navBarTranslucent)]) needFake = YES;
        
        _HBFakeNavgationBar *toFakeBar, *fromFakeBar;
        if (needFake) {
            
            toFakeBar = [[_HBFakeNavgationBar alloc] init];
            [toFakeBar updateBarWithViewController:to];
            [to.view addSubview:toFakeBar];
            
            fromFakeBar = [[_HBFakeNavgationBar alloc] init];
            [fromFakeBar updateBarWithViewController:from];
            [from.view addSubview:fromFakeBar];
            [self fixFakeBarFrame:fromFakeBar view:from.view navigationBar:navBar];
            
            [self addObserveViewController:to navgationBar:navBar withFakeBar:toFakeBar];
            [self addObserveViewController:from navgationBar:navBar withFakeBar:fromFakeBar];
            
            [navBar configFakeStyle];
        }
            
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            if (!needFake) {
                [navBar configBarStyleWithViewController:to];
            }
            [navBar configTitleStyleWithViewController:to];
            
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            UIViewController *target = to;
            if (context.isCancelled) {
                target = from;
            }
            [navBar configBarStyleWithViewController:target];
            [navBar configTitleStyleWithViewController:target];
            if (needFake) {
                [self removeObserverWithViewController:to];
                [self removeObserverWithViewController:from];
                [toFakeBar removeFromSuperview];
                [fromFakeBar removeFromSuperview];
            }
        }];
        
    } else {
        [navBar configBarStyleWithViewController:viewController];
        [navBar configTitleStyleWithViewController:viewController];
    }
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    
}

- (void)fixFakeBarFrame:(UIView *)fakeBar
                   view:(UIView *)targetView
          navigationBar:(UINavigationBar *)navBar {
    CGRect frame = [navBar.barBgView.superview convertRect:navBar.barBgView.frame toView:targetView];
    frame.origin.x = targetView.bounds.origin.x;
    fakeBar.frame = frame;
}

- (void)addObserveViewController:(UIViewController *)vc
                    navgationBar:(UINavigationBar *)navBar
                     withFakeBar:(UIView *)fakeBar {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
    NSString *keyPath1 = NSStringFromSelector(@selector(bounds));
    NSString *keyPath2 = NSStringFromSelector(@selector(frame));
    __weak typeof(self) weakSelf = self;
    HBKVOBlock block = ^(NSString *keyPath, id obj, NSDictionary *change, void *context) {
        [weakSelf fixFakeBarFrame:fakeBar view:vc.view navigationBar:navBar];
    };
    
    [vc.view hb_addObserverForKeyPath:keyPath1
                              options:options
                              context:NULL
                            withBlock:block];
    
    [vc.view hb_addObserverForKeyPath:keyPath2
                              options:options
                              context:NULL
                            withBlock:block];
}

- (void)removeObserverWithViewController:(UIViewController *)vc {
    NSString *keyPath1 = NSStringFromSelector(@selector(bounds));
    NSString *keyPath2 = NSStringFromSelector(@selector(frame));
    [vc.view hb_removeObserverBlockForKeyPath:keyPath1];
    [vc.view hb_removeObserverBlockForKeyPath:keyPath2];
}

@end
