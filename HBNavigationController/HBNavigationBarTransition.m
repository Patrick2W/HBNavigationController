//
//  HBNavigationBarTransition.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/15.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "HBNavigationBarTransition.h"
#import "UINavigationBar+HBConfig.h"
#import "NSObject+YYAddForKVO.h"

NS_INLINE BOOL HBAlphaIsEqual(CGFloat alpha1, CGFloat alpha2) {
    NSInteger ap1 = alpha1 * 10000;
    NSInteger ap2 = alpha2 * 10000;
    return ap1 == ap2;
}

NS_INLINE BOOL HBImageIsEqual(UIImage *image1, UIImage *image2) {
    if (image1 == image2) return YES;
    if (image1 && image2) {
        NSData *data1 = UIImagePNGRepresentation(image1);
        NSData *data2 = UIImagePNGRepresentation(image2);
        return [data1 isEqual:data2];
    }
    return NO;
}


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


@interface HBNavigationBarTransition ()

@property (strong, nonatomic) _HBFakeNavgationBar *toFadeBar, *fromFadeBar;

@end


@implementation HBNavigationBarTransition

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    id <UIViewControllerTransitionCoordinator> coordinator = navigationController.transitionCoordinator;
    UINavigationBar *navBar = navigationController.navigationBar;
    if (coordinator) {
        UIViewController *from = [coordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *to = viewController;
        
        BOOL same = HBImageIsEqual(from.navBarBgImage, to.navBarBgImage) && HBAlphaIsEqual(from.navBarBgAlpha, to.navBarBgAlpha);
        
        if (!same) {
            
            self.toFadeBar = [[_HBFakeNavgationBar alloc] init];
            [self.toFadeBar updateBarWithViewController:to];
            [to.view addSubview:self.toFadeBar];
            
            self.fromFadeBar = [[_HBFakeNavgationBar alloc] init];
            [self.fromFadeBar updateBarWithViewController:from];
            [from.view addSubview:self.fromFadeBar];
            
            [self addObserveViewController:to navgationBar:navBar];
            [self addObserveViewController:from navgationBar:navBar];
            
            [navBar updateNavigationStyle:nil];
            
            
            [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                
                
            } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                
                if (context.isCancelled) {
                    [navBar updateNavigationStyle:from];
                } else {
                    [navBar updateNavigationStyle:to];
                }
                [self removeObserverWithViewController:to];
                [self removeObserverWithViewController:from];
                [self.toFadeBar removeFromSuperview];
                [self.fromFadeBar removeFromSuperview];
            }];
        } else {
            [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                if (context.isCancelled) {
                    [navBar updateNavigationStyle:from];
                } else {
                    [navBar updateNavigationStyle:to];
                }
            }];
        }
        
    } else {
        [navBar updateNavigationStyle:viewController];
    }
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    
}

- (void)fixFadeBarFrame:(_HBFakeNavgationBar *)fadeBar
                   view:(UIView *)targetView
          navigationBar:(UINavigationBar *)navBar {
    CGRect frame = [navBar.barBgView.superview convertRect:navBar.barBgView.frame toView:targetView];
    frame.origin.x = targetView.bounds.origin.x;
    fadeBar.frame = frame;
}

- (void)addObserveViewController:(UIViewController *)vc navgationBar:(UINavigationBar *)navBar {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
    [vc.view addObserver:self forKeyPath:NSStringFromSelector(@selector(bounds)) options:options context:&vc];
    [vc.view addObserver:self forKeyPath:NSStringFromSelector(@selector(frame)) options:options context:&vc];
}

- (void)removeObserverWithViewController:(UIViewController *)vc {
    [vc.view removeObserver:self forKeyPath:NSStringFromSelector(@selector(bounds))];
    [vc.view removeObserver:self forKeyPath:NSStringFromSelector(@selector(frame))];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(bounds))] ||
        [keyPath isEqualToString:NSStringFromSelector(@selector(frame))]) {
        if ([object isKindOfClass:[UIView class]]) {
            
            
        }
    }
}

@end
