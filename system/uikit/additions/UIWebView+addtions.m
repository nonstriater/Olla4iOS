//
//  UIWebView+addtions.m
//  Olla
//
//  Created by null on 15-3-20.
//  Copyright (c) 2015年 xiaoran. All rights reserved.
//

#import "UIWebView+addtions.h"

@implementation UIWebView (addtions)

//
- (UIImage *)screenshot{
    UIGraphicsBeginImageContextWithOptions(self.scrollView.contentSize, NO, 0);
    CGPoint oldContentOffset = self.scrollView.contentOffset;
    CGRect oldFrame = self.scrollView.frame;
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    [self.scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    self.scrollView.contentOffset = oldContentOffset;
    self.scrollView.frame = oldFrame;
    UIGraphicsEndImageContext();
    return image;
    
}



@end
