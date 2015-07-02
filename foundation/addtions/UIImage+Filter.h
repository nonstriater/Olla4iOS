//
//  UIImage+Filter.h
//  FuShuo
//
//  Created by nonstriater on 14-1-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Filter)

- (UIImage *)LOMOFilterOutput;  // LOMO
- (UIImage *)grayFilterOutput;  //黑白
- (UIImage *)vintageFilterOutput; //复古
- (UIImage *)geteFilterOutput;  // 哥特
- (UIImage *)sharpFilterOutput;  // 锐化
- (UIImage *)elegantFilterOutput; //淡雅
- (UIImage *)redWineFilterOutput; // 酒红
- (UIImage *)quietFilterOutput;    //清宁
- (UIImage *)romanticFilterOutput; // 浪漫
- (UIImage *)shineFilterOutput;  // 光晕
- (UIImage *)blueFilterOutput;   // 蓝调
- (UIImage *)dreamFilterOutput; // 梦幻
- (UIImage *)darkFilterOutput; // 夜色

- (UIImage *)gaussBlurFilterWithLevel:(CGFloat)blurLevel; // 高斯模糊X
- (UIImage *)blurWithLevel:(CGFloat)blurLevel;

@end
