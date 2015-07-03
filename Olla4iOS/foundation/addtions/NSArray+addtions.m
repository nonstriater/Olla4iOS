//
//  NSArray+addtions.m
//  FuShuo
//
//  Created by nonstriater on 14-1-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "foundation.h"

@implementation NSArray (addtions)

+ (instancetype)arrayWithObject:(id)object count:(NSUInteger)cnt{
    NSMutableArray *ma = [[NSMutableArray alloc] initWithCapacity:cnt];
    for (int i=0; i<cnt; i++) {
        [ma addObject:object];
    }
    return [ma copy];
}

- (BOOL)isArray{
    return [self isKindOfClass:[NSArray class]];
}

- (NSArray*)propertyListArray{

    //NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    NSMutableArray *newArray = [NSMutableArray array];
    for (id object in self) {// 在枚举的时候不能改变
        if ([object isNull]) {
//            [array removeObject:object];
            continue;
        }
        
        if (!([object isDictionary] ||
            [object isString] ||
            [object isNumber]) ) {
            //[array removeObject:object];
            continue;
        }
        
        if ([object isDictionary]) {
            [newArray addObject:[object propertyListDictionary]];
            continue;
            //[array replaceObject:object withObject:[object propertyListDictionary]];
        }
        
        [newArray addObject:object];
    }
    
    return newArray ;
}


@end
