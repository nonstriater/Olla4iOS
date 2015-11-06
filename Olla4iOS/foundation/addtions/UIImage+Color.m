//
//  UIImage+Color.m
//  FuShuo
//
//  Created by nonstriater on 14-1-27.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "UIImage+Color.h"


@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color{
    
    UIImage *image;
    CGRect rect = CGRectMake(0, 0, 1.f, 1.f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithAsset:(ALAsset *)asset{
    CGImageRef imageRef = [[asset defaultRepresentation] fullResolutionImage];
    return [UIImage imageWithCGImage:imageRef];
}


- (UIImage *)imageWithTintColor:(UIColor *)color{
    return [self imageWithTintColor:color blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)imageWithTintColor:(UIColor *)color blendMode:(CGBlendMode)mode{
    UIGraphicsBeginImageContext(self.size);
    [color setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    [self drawInRect:bounds blendMode:mode alpha:1.f];
    
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return destImage;
}

@end

