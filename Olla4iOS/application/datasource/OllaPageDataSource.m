//
//  OllaPageDataSource.m
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaPageDataSource.h"
#import "foundation.h"

@implementation OllaPageDataSource

- (id)init{
    if (self = [super init]) {
     
        self.pageIndex = 1;
        self.pageSize = 20;
        
        self.hasMoreData = NO; // 初始为NO,第一页数据加载不需要判断这个才行
        
    }
    return self;
}

- (void)loadMoreData{

    _pageIndex++;
    self.loading = YES;
    
    if ([self.delegate respondsToSelector:@selector(dataSourceWillLoading:)]) {
        [self.delegate dataSourceWillLoading:self];
    }
    
    [self loadData];
}

// 重写 , 刷新
- (void)refreshData{

    if (_pageIndex !=1 ) {
        _pageIndex = 1;   
    }

    _hasMoreData = YES;
    [super refreshData];
    
}

- (void)loadResultsData:(id)resultsData{
    if (self.pageIndex==1 && [self.dataObjects count]>0) {
        [self.dataObjects removeAllObjects];
    }
    
    //[super loadResultsData:resultsData];
    id items = self.dataKey ? [resultsData dataForKeyPath:self.dataKey]:resultsData;
    if ([items isKindOfClass:[NSArray class]]) {
        [[self dataObjects] addObjectsFromArray:items];
        
    }else if([items isKindOfClass:[NSDictionary class]]){
        [[self dataObjects] addObject:[NSMutableDictionary dictionaryWithDictionary:items]];
    }
    
}


- (NSUInteger)downlinkPageTaskPageSize{
    return _pageSize;
}

- (NSUInteger)downlinkPageTaskPageIndex{
    return _pageIndex;
}

@end
