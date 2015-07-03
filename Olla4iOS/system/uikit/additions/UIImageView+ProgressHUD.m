//
//  UIImageView+ProgressHUD.m
//  FuShuo
//
//  Created by nonstriater on 14-5-3.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "UIImageView+ProgressHUD.h"
#import "Olla4iOS.h"

static const void *ImageViewShowHUDProgressView = &ImageViewShowHUDProgressView;

@implementation UIImageView (ProgressHUD)

- (void)showHUDWithProgress:(CGFloat)progress{

    MBRoundProgressView *progressView = objc_getAssociatedObject(self, ImageViewShowHUDProgressView);
    if (!progressView) {
        
        progressView = [[MBRoundProgressView alloc] initWithFrame:CGRectMake(0, 0, 80.f, 80.f)];
        progressView.center = self.center;
        progressView.progress = 0.f;
        progressView.progressTintColor = [UIColor whiteColor];
        progressView.backgroundTintColor = [UIColor darkGrayColor];
        progressView.annular = YES;
        [self addSubview:progressView];
        objc_setAssociatedObject(self, ImageViewShowHUDProgressView, progressView, OBJC_ASSOCIATION_RETAIN);
        
    }
    
    progressView.progress = progress;
    

}


- (void)removeHUD{

    MBRoundProgressView *progressView = objc_getAssociatedObject(self, ImageViewShowHUDProgressView);
    [progressView removeFromSuperview];
    objc_setAssociatedObject(self, ImageViewShowHUDProgressView, nil, OBJC_ASSOCIATION_ASSIGN);
    
}

@end
