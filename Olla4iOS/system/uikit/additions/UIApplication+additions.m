//
//  UIApplication+additions.m
//  EverPhoto
//
//  Created by null on 15-5-18.
//  Copyright (c) 2015年 bytedance. All rights reserved.
//

#import "UIApplication+additions.h"

@implementation UIApplication (additions)

- (void)dismissKeyboard{
    
    [[UIApplication sharedApplication] sendAction:nil to:nil from:nil forEvent:nil];
    
}

@end
