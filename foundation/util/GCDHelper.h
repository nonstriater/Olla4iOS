//
//  BlockHelper.h
//  FuShuo
//
//  Created by nonstriater on 14-4-23.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDHelper : NSObject

+ (void)handleImageInBackground:(void (^)())block completion:(void (^)())block;
// 当一连串的事情顺序执行时调用
+ (void)handleSerialTask:(void (^)())block completion:(void (^)())complete;

+ (void)dispatchBlock:(void (^)())block completion:(void (^)())block;


@end
