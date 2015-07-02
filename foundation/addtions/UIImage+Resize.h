//
//  UIImage+Resize.h
//  FuShuo
//
//  Created by nonstriater on 14-1-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

// 图片可能会变形
- (UIImage *)resizeImageWithSize:(CGSize)size;


// 考虑到图片的比例来压缩，以宽？高？为准
- (UIImage *)resizeAspectImageWithSize:(CGSize)size;

@end
