//
//  OllaImageBrowserView.h
//  OllaFramework
//
//  Created by null on 14-9-5.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>

//单张图片大图浏览
@interface OllaImageBrowserView : UIView

@property(nonatomic,assign) CGRect startRect;
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,strong) NSString *originalURL;

@property(nonatomic,strong) NSString *imagePath;

@end
