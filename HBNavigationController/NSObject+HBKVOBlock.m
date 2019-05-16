//
//  NSObject+HBKVOBlock.m
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/16.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import "NSObject+HBKVOBlock.h"
#import <objc/runtime.h>

@interface _HBObjectKVOObserver : NSObject

- (instancetype)initWithBlock:(HBKVOBlock)block;

@property (copy, nonatomic) HBKVOBlock block;

@end


@implementation _HBObjectKVOObserver

- (instancetype)initWithBlock:(HBKVOBlock)block {
    self = [super init];
    if (self) {
        _block = block;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if (!self.block) return;
    self.block(keyPath, object, change, context);
}

@end



@implementation NSObject (HBKVOBlock)

- (void)hb_addObserverForKeyPath:(NSString *)keyPath
                         options:(NSKeyValueObservingOptions)options
                         context:(void *)context
                       withBlock:(HBKVOBlock)block {
    if (!keyPath || !block) return;
    _HBObjectKVOObserver *obser = [[_HBObjectKVOObserver alloc] initWithBlock:block];
    [self _saveObserver:obser withKeyPath:keyPath];
    [self addObserver:obser forKeyPath:keyPath options:options context:context];
}

- (void)hb_removeObserverBlockForKeyPath:(NSString *)keyPath {
    if (!keyPath) return;
    NSMutableDictionary *map = [self _blockObserverMap];
    NSMutableArray *obsers = map[keyPath];
    [obsers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeObserver:obj forKeyPath:keyPath];
    }];
    [map removeObjectForKey:keyPath];
}

- (void)hb_removeAllObserverBlocks {
    NSMutableDictionary *map = [self _blockObserverMap];
    [map enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSArray * _Nonnull obj, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self removeObserver:obj forKeyPath:key];
        }];
    }];
    [map removeAllObjects];
}

- (void)_saveObserver:(_HBObjectKVOObserver *)obser withKeyPath:(NSString *)keyPath {
    NSMutableDictionary *map = [self _blockObserverMap];
    NSMutableArray *obsers = [map objectForKey:keyPath];
    if (!obsers) {
        obsers = [NSMutableArray array];
        [map setObject:obsers forKey:keyPath];
    }
    [obsers addObject:obser];
}

- (NSMutableDictionary *)_blockObserverMap {
    NSMutableDictionary *oMap = objc_getAssociatedObject(self, _cmd);
    if (!oMap) {
        oMap = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, oMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return oMap;
}

@end
