//
//  UIImageView+CacheURL.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-3.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "UIImageView+CacheURL.h"
#import "Olla4iOS.h"

static NSString *defaultPlaceholderImage = @"headphoto_default_128";
const static void *placeholderKey = &placeholderKey;
const static void *errorImageKey = &errorImageKey;
const static void *placeholderDisableKey = &placeholderDisableKey;

@implementation UIImageView (CacheURL)

@dynamic remoteImageURL;


- (NSString *)placeholder{
    NSString *ph = objc_getAssociatedObject(self, placeholderKey);
    return ph;
}

- (void)setPlaceholder:(NSString *)placeholder{
    objc_setAssociatedObject(self, placeholderKey, placeholder, OBJC_ASSOCIATION_COPY);
}


- (BOOL)placeholderDisable{
    return [objc_getAssociatedObject(self, placeholderDisableKey) boolValue];
}

- (void)setPlaceholderDisable:(BOOL)placeholderDisable{
    objc_setAssociatedObject(self, placeholderDisableKey, @(placeholderDisable), OBJC_ASSOCIATION_ASSIGN);
}


- (NSString *)errorImageName{
    return  objc_getAssociatedObject(self, errorImageKey);
}

- (void)setErrorImageName:(NSString *)errorImageName{
    objc_setAssociatedObject(self,errorImageKey , errorImageName, OBJC_ASSOCIATION_COPY);
}

// 网络url
- (void)setRemoteImageURL:(NSString *)remoteImageURL{
    
    if ([self.placeholder length]==0) {
        self.placeholder = defaultPlaceholderImage;
    }
    
    if (self.placeholderDisable) {
        self.placeholder = nil;
    }
    
    if(![remoteImageURL isString] || [remoteImageURL length]==0){
        DDLogError(@"非法的url:%@",remoteImageURL);
        self.image = [UIImage imageNamed:self.placeholder];
        return;
    }
    
    __weak UIImageView *wself = self;
    [self sd_setImageWithURL:[NSURL URLWithString:remoteImageURL] placeholderImage:[UIImage imageNamed:self.placeholder] options:SDWebImageAllowInvalidSSLCertificates|SDWebImageRetryFailed completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType,NSURL *imageURL){
        
        dispatch_main_sync_safe(^{
            __strong UIImageView *sself = wself;
            if (!sself) return;
            if (error) {
                DDLogError(@"图片(url=%@)下载失败：%@",remoteImageURL,error);
                if ([sself.errorImageName length]==0) {
                    sself.errorImageName = @"PhotoDownloadfailed";
                }
                [sself setImage:[UIImage imageNamed:sself.errorImageName]];
            }
        });
        
    }];
 
}

- (void)cancelCurrentImageLoading{
    [self sd_cancelCurrentImageLoad];
}


@end



