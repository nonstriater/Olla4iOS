//
//  NSStringValueTransformer.m
//  Olla4iOSDemo
//
//  Created by null on 15/7/10.
//  Copyright (c) 2015年 nonstriater. All rights reserved.
//

#import "NSStringValueTransformer.h"
#import "foundation.h"

@implementation NSStringValueTransformer

//指定转换的类型
+(Class)transformedValueClass{
    return [NSString class];
}

//如果是number转为string类型
- (id)transformedValue:(id)value{
    if ([value isNumber]) {
        return [(NSNumber *)value stringValue];
    }
    return nil;
}

@end
