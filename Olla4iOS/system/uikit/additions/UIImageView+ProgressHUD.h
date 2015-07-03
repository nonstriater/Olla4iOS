//
//  UIImageView+ProgressHUD.h
//  FuShuo
//
//  Created by nonstriater on 14-5-3.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ProgressHUD)

- (void)showHUDWithProgress:(CGFloat)progress;
- (void)removeHUD;

@end
