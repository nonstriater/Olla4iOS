//
//  OllaImageBrowserView.m
//  OllaFramework
//
//  Created by null on 14-9-5.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaImageBrowserView.h"
#import "Olla4iOS.h"

@interface OllaImageBrowserView (){
    
    UIView *_maskView;
    UIImageView *_imageView;
}

@end


@implementation OllaImageBrowserView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{

    [self setupMaskView];
    [self setupImageView];
    [self addTapGesture];
    [self showWithAnimation];

}


- (void)showWithAnimation{
    
    _maskView.alpha = 0.f;
    [UIView animateWithDuration:0.4 animations:^{
        _maskView.alpha = 1.0;
    }];
    
}

- (void)hideWithAnimation{
    
    self.alpha = 1.f;
    [UIView animateWithDuration:0.4 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.alpha = 0.f;
        _imageView.frame = _startRect;
        
    } completion:^(BOOL complete){
        if (complete) {
            [self removeFromSuperview];
        }
        
    }];
}

- (void)addTapGesture{
    
    [self tap:^(UITapGestureRecognizer *tapGesture) {
         [self hideWithAnimation];
    }];
}


- (void)setupMaskView{
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor blackColor];
    _maskView = view;
    [self addSubview:view];
    
}

- (void)setupImageView{
    
    __block UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.startRect];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image = self.image;
    [self addSubview:imageView];
    _imageView = imageView;
    
    
    if (self.imagePath) {//文件路径
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:self.imagePath];
        [self imageDownloadSuccessHandler:image];
        return;
    }
    
    if(self.originalURL){//网络
    
        __weak typeof(self) weakSelf = self;
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.originalURL] placeholderImage:self.image options:SDWebImageAllowInvalidSSLCertificates|SDWebImageRetryFailed progress:^(NSInteger receiveSize,NSInteger expectSize){
        
            //[weakSelf showHUDWithProgress:receiveSize/expectSize];
        
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        
            if (error) {
                NSLog(@"image browser error:%@",error);
                //[JDStatusBarNotification showWithStatus:@"image download fail" dismissAfter:1.f styleName:JDStatusBarStyleDark];
                return ;
            }
        
            [weakSelf imageDownloadSuccessHandler:image];
            
        }];
    
    }
    
}

- (void)showHUDWithProgress:(CGFloat)progress{
    
    [_imageView showHUDWithProgress:progress];
}


- (void)imageDownloadSuccessHandler:(UIImage *)image{
    
    /**
     *这里图片尺寸各异,下面的算法只适合高度不超过屏幕高度的情况
     */
    
   // [_imageView removeHUD];
    
    _imageView.image = image;
    CGFloat height = 320*image.size.height/image.size.width;
    CGRect rect = CGRectMake(0, (CGRectGetHeight(self.frame)-height)/2, 320.f, height);
    [UIView animateWithDuration:0.4 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _imageView.frame = rect;
    } completion:nil];
    
}



@end



