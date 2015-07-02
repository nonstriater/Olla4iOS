//
//  NSObject+KeyPath.m
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "NSObject+KeyPath.h"

@implementation NSObject (KeyPath)

// resutl.data.imgs 递归实现
- (id)dataForKeyPath:(NSString *)keyPath{

    NSRange range = [keyPath rangeOfString:@"."];
    if (range.location == NSNotFound) {
        id value = nil;
        @try {
            value = [self valueForKey:keyPath];
        }
        @catch (NSException *exception) {
            NSLog(@"ERROR:[%@ valueforKey:%@] exception!!",[self class],keyPath);
            value = nil;
        }
 
        return value;
    }
    NSString *key = [keyPath substringToIndex:range.location];
    
    //id value = [self valueForKey:key];// 如果没有这个属性，会崩溃
    id value = nil;
    @try {
        value = [self valueForKey:key];
    }
    @catch (NSException *exception) {
        NSLog(@"ERROR:[%@ valueforKey:%@] exception!!",[self class],key);
        value = nil;
    }

    return [value dataForKeyPath:[keyPath substringFromIndex:range.location+range.length]];
}

@end
