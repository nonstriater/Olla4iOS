//
//  OllaRefreshView.h
//  OllaFramework
//  https://github.com/Sephiroth87/ODRefreshControl
//  Created by nonstriater on 14-7-17.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "IOllaLoadingProtocol.h"


//TODO:8
@interface OllaRefreshView : UIControl<IOllaRefreshView>{
    CAShapeLayer *_shapeLayer;
    CAShapeLayer *_arrowLayer;
    CAShapeLayer *_highlightLayer;
    UIView *_activity;
    BOOL _refreshing;
    BOOL _canRefresh;
    BOOL _ignoreInset;
    BOOL _ignoreOffset;
    BOOL _didSetInset;
    BOOL _hasSectionHeaders;
    CGFloat _lastOffset;

}

@property (nonatomic, readonly, getter=isRefreshing) BOOL refreshing;

@property (nonatomic, strong) UIColor *tintColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIActivityIndicatorViewStyle activityIndicatorViewStyle UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *activityIndicatorViewColor UI_APPEARANCE_SELECTOR; // iOS5 or more


- (id)initInScrollView:(UIScrollView *)scrollView;
- (id)initInScrollView:(UIScrollView *)scrollView activityIndicatorView:(UIView *)activity;

@end
