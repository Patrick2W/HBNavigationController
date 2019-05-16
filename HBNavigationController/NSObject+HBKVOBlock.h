//
//  NSObject+HBKVOBlock.h
//  HBNavigationControllerDemo
//
//  Created by cheyun on 2019/5/16.
//  Copyright © 2019 cnvex.cn. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^HBKVOBlock)(NSString *keyPath, id obj, NSDictionary *change, void *context);

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HBKVOBlock)

/**
 添加keyPath监听
 */
- (void)hb_addObserverForKeyPath:(NSString *)keyPath
                      options:(NSKeyValueObservingOptions)options
                      context:(nullable void *)context
                    withBlock:(HBKVOBlock)block;

/**
 停止keyPath block监听
 */
- (void)hb_removeObserverBlockForKeyPath:(NSString *)keyPath;

/**
 停止所有block监听
 */
- (void)hb_removeAllObserverBlocks;

@end

NS_ASSUME_NONNULL_END
