//
//  UIImage+Color.h
//  FuShuo
//
//  Created by nonstriater on 14-1-27.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithAsset:(ALAsset *)asset;

- (UIImage *)imageWithTintColor:(UIColor *)color;
- (UIImage *)imageWithTintColor:(UIColor *)color blendMode:(CGBlendMode)mode;

@end
