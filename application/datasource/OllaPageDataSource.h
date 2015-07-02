//
//  OllaPageDataSource.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaDataSource.h"
#import "IOllaDownlinkPageTask.h"

@interface OllaPageDataSource : OllaDataSource<IOllaDownlinkPageTask>

@property(nonatomic,assign) NSUInteger pageIndex;
@property(nonatomic,assign) NSUInteger pageSize;
@property(nonatomic,assign) BOOL hasMoreData;

- (void)loadMoreData;


@end
