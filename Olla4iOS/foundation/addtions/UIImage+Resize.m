//
//  UIImage+Resize.m
//  FuShuo
//
//  Created by nonstriater on 14-1-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

// not thread safe
- (UIImage *)resizeImageWithSize:(CGSize)size{

    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
    
}


//eg 640*1136 , 以宽为准，高度等比例缩放
- (UIImage *)resizeAspectImageWithSize:(CGSize)size{


    CGFloat widthScale = size.width/self.size.width; // 以宽为准
    CGFloat height = widthScale * self.size.height;//

    UIGraphicsBeginImageContext(CGSizeMake(size.width,height));
    [self drawInRect:CGRectMake(0, 0, size.width, height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}


@end
