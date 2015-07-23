//
//  OllaBannerView.h
//  Olla4iOSDemo
//
//  Created by null on 15/7/23.
//  Copyright (c) 2015年 nonstriater. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OllaBannerView;
typedef  void (^OllaItemSelectBlock)(OllaBannerView *bannerView,NSUInteger index);

@interface OllaBannerView : UIView

//url,stringUrl,uiimage
@property (nonatomic,copy) NSArray *items;
@property (nonatomic,assign) BOOL pageControlHidden;

/**
 *  自动播放,默认NO
 */
@property (nonatomic,assign) BOOL autoPlay;

- (void)itemSelectedThen:(OllaItemSelectBlock)block;

@end
