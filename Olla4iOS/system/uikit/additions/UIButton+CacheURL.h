//
//  UIButton+URL.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIButton (CacheURL)


@property(nonatomic,strong) IBInspectable NSString *remoteImageURL;
@property(nonatomic,strong) IBInspectable NSString *remoteBackgroundImageURL;

@property(nonatomic,strong) IBInspectable NSString *placeholder;
@property(nonatomic,assign) IBInspectable BOOL placeholderDisable;
@property(nonatomic,strong) IBInspectable UIColor *selectedBackgroundColor;

@property(nonatomic,strong) UIImage *image;
@property(nonatomic,copy) NSString *title;



@end
