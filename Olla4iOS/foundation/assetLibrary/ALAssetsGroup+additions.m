//
//  ALAssetsGroup+additions.m
//  EverPhoto
//
//  Created by null on 15-5-19.
//  Copyright (c) 2015年 bytedance. All rights reserved.
//

#import "ALAssetsGroup+additions.h"

@implementation ALAssetsGroup (additions)

- (NSString *)name{
    return [self valueForProperty:ALAssetsGroupPropertyName];
}

@end
