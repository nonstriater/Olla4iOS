//
//  ALAsset+additions.h
//  EverPhoto
//
//  Created by null on 15-5-19.
//  Copyright (c) 2015年 bytedance. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

@interface ALAsset (additions)

//type
- (BOOL)isPhoto;
- (BOOL)isVideo;

//
- (BOOL)isEqual:(id)object;

//原图的md5值
- (NSString *)md5Encode;

//是否是屏幕截图
- (BOOL)isScreenshot;

@end
