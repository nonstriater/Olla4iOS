//
//  UIButton+URL.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//


#import "Olla4iOS.h"

static NSString *defaultPlaceholderImage = @"headphoto_default_128";
const static void *placeholderKey = &placeholderKey;
const static void *placeholderDisableKey = &placeholderDisableKey;

@implementation UIButton (CacheURL)

@dynamic remoteImageURL;
@dynamic remoteBackgroundImageURL;
@dynamic image;
@dynamic placeholderDisable;
@dynamic selectedBackgroundColor;

- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor{
    [self setBackgroundImage:[UIImage imageWithColor:selectedBackgroundColor] forState:UIControlStateHighlighted];
}


- (NSString *)placeholder{
    NSString *ph = objc_getAssociatedObject(self, placeholderKey);
    return ph;
}

- (void)setPlaceholder:(NSString *)placeholder{
    objc_setAssociatedObject(self, placeholderKey, placeholder, OBJC_ASSOCIATION_COPY);
}

- (void)setTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
}

- (NSString *)title{
    return [self titleForState:UIControlStateNormal];
}

- (void)setImage:(UIImage *)image{
    [self setImage:image forState:UIControlStateNormal];
}

- (UIImage *)image{
    return [self imageForState:UIControlStateNormal];
}

- (BOOL)placeholderDisable{
    return [objc_getAssociatedObject(self, placeholderDisableKey) boolValue];
}

- (void)setPlaceholderDisable:(BOOL)placeholderDisable{
    objc_setAssociatedObject(self, placeholderDisableKey, @(placeholderDisable), OBJC_ASSOCIATION_ASSIGN);
}

-(void)setRemoteImageURL:(NSString *)remoteImageURL{
    
    if ([self.placeholder length]==0) {
        self.placeholder = defaultPlaceholderImage;
    }
    
    if (self.placeholderDisable) {
        self.placeholder = nil;
    }
    
    if(![remoteImageURL isString]){
        DDLogError(@"非法的url:%@",remoteImageURL);
        [self setImage:[UIImage imageNamed:self.placeholder] forState:UIControlStateNormal];
        return;
    }
   
    __weak UIButton *wself = self;
    [self sd_setImageWithURL:[NSURL URLWithString:remoteImageURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:self.placeholder] options:SDWebImageAllowInvalidSSLCertificates|SDWebImageRetryFailed completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType,NSURL *imageURL){
        
        dispatch_main_sync_safe(^{
            __strong UIButton *sself = wself;
            if (!sself) return;
            if (error) {
                DDLogError(@"图片(url=%@)下载失败：%@",remoteImageURL,error);
                [sself setImage:[UIImage imageNamed:@"PhotoDownloadfailed"] forState:UIControlStateNormal];
            }
        });
        
    }];
}

-(void)setRemoteBackgroundImageURL:(NSString *)remoteBackgroundImageURL{
    if (![remoteBackgroundImageURL isKindOfClass:[NSString class]]) {
        return;
    }
    [self sd_setBackgroundImageWithURL:[NSURL URLWithString:remoteBackgroundImageURL] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
}



@end
