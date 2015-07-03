//
//  UIViewController+HUD.h
//  EverPhoto
//
//  Created by null on 15-5-11.
//  Copyright (c) 2015年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

/**
 *  显示hud停留n秒
 *
 *  @param text
 *  @param seconds
 */
- (void)showHUDWithText:(NSString *)text dismissAfter:(NSTimeInterval)seconds;
- (void)showHUDWithText:(NSString *)text dismissAfter:(NSTimeInterval)seconds completeBlock:(void (^)())block;

//进度，完成后执行block
- (void)showHUDWithProgress:(float)progress text:(NSString *)text finishedBlock:(void (^)())block;


- (void)showCustomHUDWithText:(NSString *)text image:(UIImage *)image dismissAfter:(NSTimeInterval)seconds;


@end
