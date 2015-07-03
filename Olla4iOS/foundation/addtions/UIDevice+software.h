//
//  UIDevice+software.h
//  FuShuo
//
//  Created by nonstriater on 14-2-8.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (software)

+ (BOOL)isJailBreak;

/**
 *  app 占用的内存
 *
 *  @return 内存大小
 */
+ (double)usedMemery;


+ (double)CPUUsage;



@end
