//
//  IOllaLoadingProtocol.h
//  TestFoundation
//
//  Created by null on 15/7/2.
//  Copyright (c) 2015年 nonstriater. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol IOllaLoadingMoreView <NSObject>

@property(nonatomic,weak) IBOutlet UILabel *textLabel;
@property(nonatomic,weak) IBOutlet UIActivityIndicatorView *indicatorView;
@property(nonatomic,assign) BOOL isLoading;
@property(nonatomic,assign) BOOL hasMoreData;

- (void)startLoading;
- (void)stopLoading;


@end



@protocol IOllaRefreshView <NSObject>

- (instancetype)initInScrollView:(UIScrollView *)scrollView;

- (void)beginRefreshing;
- (void)endRefreshing;

@end




