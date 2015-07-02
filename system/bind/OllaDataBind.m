//
//  OllaDataBind.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-2.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaDataBind.h"
#import "NSObject+KeyPath.h"

@implementation OllaDataBind

- (void)applyDataBinding:(id)data{
    
    // 这是2个机关，_eanbledKeyPath 是0 断开bind ，——disabledKeyPath是1断开bind
    if (_enabledKeyPath) {
        if (![self booleanValue:[data dataForKeyPath:_enabledKeyPath]]) {
            return;
        }
    }
    
    if (_disabledKeyPath) {
        if ([self booleanValue:[data dataForKeyPath:_disabledKeyPath]]) {
            return;
        }
    }
    
    id value=_value;
    if ([_dataKeyPath length]>0) {
        value = [data dataForKeyPath:_dataKeyPath];
    }
    if ([value isKindOfClass:[NSNull class]]) {
        value = nil;
    }
    for (UIView *view in _views) {
        //如果_urPropertyKeyPath 不满足view上的 key-value coding-compaint，这里会导致崩溃
        if ([_propertyKeyPath length]>0) {
            
            if ([value isKindOfClass:[NSNumber class]] && [_propertyKeyPath isEqualToString:@"text"]) {
                value = [value stringValue];
            }
            [view setValue:value forKeyPath:_propertyKeyPath];
        }
    }
}


- (BOOL)booleanValue:(id)key{

    if ([key isKindOfClass:[NSNumber class]]) {
        return [key boolValue];
    }else if([key isKindOfClass:[NSString class]]){
        // "ture" or "false"  ,, "yes" or "no" ,,  @"0" or @"1"
        if ([key isEqualToString:@"0"]||[[key uppercaseString] isEqualToString:@"NO"]||[[key uppercaseString] isEqualToString:@"TURE"]) {
            return NO;
        }
    }
    
    return YES;
}


@end
