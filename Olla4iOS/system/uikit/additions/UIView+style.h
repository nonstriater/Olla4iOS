//
//  UIView+style.h
//  OllaFramework
//
//  Created by nonstriater on 14-8-13.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (style)

@property(nonatomic,strong) IBInspectable NSString *bgColor;
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property(nonatomic,strong) IBInspectable UIColor *borderColor;

@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic,assign) IBInspectable CGFloat blurRadius;

- (UIView *)instanceWithStyle:(NSString *)style;

//设置某几个角的圆角
- (void)roundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius;

@end
