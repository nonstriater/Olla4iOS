//
//  NSNumber+additions.m
//  FuShuo
//
//  Created by nonstriater on 14-2-8.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "NSNumber+additions.h"

@implementation NSNumber (additions)

- (NSString *)fileSize{
    
    NSString *ret;
    unsigned long long size = [self unsignedLongLongValue];
    if (size<1024) {
        ret = [NSString stringWithFormat:@"%llu bytes",size];
    }else if (size<1024*1024) {
        ret = [NSString stringWithFormat:@"%.1lf KB",size/1024.f];
    }else if (size<1024*1024*1024) {
        ret = [NSString stringWithFormat:@"%.1lf MB",size/(1024.f*1024.f)];
    }
   
    return ret;
}

@end
