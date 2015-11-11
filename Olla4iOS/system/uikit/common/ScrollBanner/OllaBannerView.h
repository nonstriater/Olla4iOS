//
//  OllaBannerView.h
//  Olla4iOSDemo
//
//  Created by null on 15/7/23.
//  Copyright (c) 2015年 nonstriater. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OllaBannerModelDelegate <NSObject>
@property(nonatomic, copy) NSString *imageURL;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) id userInfo;
@end


@class OllaBannerView;
typedef  void (^OllaItemSelectBlock)(OllaBannerView *bannerView,NSUInteger index);

@interface OllaBannerView : UIView

//url：nsurl,stringUrl,uiimage
@property (nonatomic,copy) NSArray *items;

/**
 *  是否隐藏pageControl空间
 */
@property (nonatomic,assign) BOOL pageControlHidden;

/**
 *  自动播放,默认NO
 */
@property (nonatomic,assign) BOOL autoPlay;

- (void)itemSelectedThen:(OllaItemSelectBlock)block;

@end





