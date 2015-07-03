//
//  UITextField+NilCheck.h
//  EverPhoto
//
//  Created by null on 15-5-17.
//  Copyright (c) 2015年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

//用户输入合法性检查
@interface UITextField (NilCheck)

- (BOOL)checkPrompt:(NSString *)prompt;

@end
