//
//  UIImageView+CacheURL.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-3.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CacheURL)

@property(nonatomic,strong) IBInspectable NSString *remoteImageURL;// 网络url
@property(nonatomic,strong) IBInspectable NSString *placeholder;
@property(nonatomic,strong) NSString *errorImageName;
@property(nonatomic,assign) BOOL placeholderDisable;//default NO

/**
 * 1. 取缓存，没有去网络取
 * 2. 取缓存，缓存失败，去网络取
 * 3. 没有缓存，直接去网络取
 * 4. 缓存图片可能还有加密存储的需求
 */

// 使用SDWebImage的图片处理
- (void)cancelCurrentImageLoading;
@end
