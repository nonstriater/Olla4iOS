//
//  UIView+additions.m
//  FuShuo
//
//  Created by nonstriater on 14-1-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "UIView+additions.h"
#import "UIImage+BoxBlur.h"
#import "UIImage+Filter.h"

@implementation UIView (additions)

- (CGFloat)originX{
    return CGRectGetMinX(self.frame);
}

- (void)setOriginX:(CGFloat) x{

    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)originY{
    return CGRectGetMinY(self.frame);
}

- (void)setOriginY:(CGFloat) y{
    
    self.frame = CGRectMake( self.frame.origin.x,y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)width{
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height{
    return CGRectGetHeight(self.frame);
}


- (void)setWidth:(CGFloat)width{
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y ,width , self.frame.size.height);
    
}

- (void)setHeight:(CGFloat)height{
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y ,self.frame.size.width , height);
}


////////////////////////////////////////////////////////
- (UIImage *)convertToImage{

    UIGraphicsBeginImageContextWithOptions(self.bounds.size,NO,[UIScreen mainScreen].scale);
    //[self.layer drawInContext:UIGraphicsGetCurrentContext()];//not work, my backgroundColor is black!
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return retImage;
    
}

- (UIImage *)imageWithRect:(CGRect)rect{
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self convertToImage].CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

- (void)blurWithRadius:(CGFloat)radius{
    
    UIImage *image = [self convertToImage];
    //UIImage *blurImage = [image drn_boxblurImageWithBlur:radius withTintColor:[UIColor clearColor]];//todo:crash in -drn_boxblurImageWithBlur
    UIImage *blurImage = [image blurWithLevel:radius];
    self.layer.contents = (__bridge id)(blurImage.CGImage);
    
}

- (void)maskWithResizableImage:(UIImage *)image{
    [self maskWithResizableImage:image padding:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)maskWithResizableImage:(UIImage *)image padding:(UIEdgeInsets)padding{
    
    if (!image) {
        return;
    }
    
    UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:image];
    imageViewMask.frame = UIEdgeInsetsInsetRect(self.bounds, padding);
    
    self.layer.mask = imageViewMask.layer;
}


- (void)maskWithImage:(UIImage *)image resizableImage:(UIEdgeInsets)capInset padding:(UIEdgeInsets)padding{
    
    UIImage *resizableImage = [image resizableImageWithCapInsets:capInset resizingMode:UIImageResizingModeStretch];
    [self maskWithResizableImage:resizableImage padding:padding];

}

- (BOOL)hasChild:(UIView *)view{

    BOOL exist = NO;
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:self];
    do{
        UIView *first = (UIView *)[queue firstObject];
        [queue removeObjectAtIndex:0];
        if (first == view) {
            exist = YES;
            break;
        }
        [queue addObjectsFromArray:[first subviews]];
        
    }while ([queue count]);
    
    return exist;
}


@end
