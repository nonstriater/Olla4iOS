//
//  UITextField+NilCheck.m
//  EverPhoto
//
//  Created by null on 15-5-17.
//  Copyright (c) 2015年 bytedance. All rights reserved.
//

#import "UITextField+NilCheck.h"
#import "UIAlertView+Blocks.h"

@implementation UITextField (NilCheck)

- (BOOL)checkPrompt:(NSString *)prompt{
    if([self.text length]==0){
        
        [UIAlertView showMessage:prompt cancelButtonTitle:@"知道了"];
        return YES;
    }
    return NO;
}

@end
