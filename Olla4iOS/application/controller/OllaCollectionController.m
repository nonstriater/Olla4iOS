//
//  OllaCollectionController.m
//  Olla
//
//  Created by null on 14-10-30.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaCollectionController.h"

@implementation OllaCollectionController

-(void)cancel{
    self.dataLoadingError = NO;
    [super cancel];
    [self stopLoading];
}

- (void)startLoading{
    self.dataLoadingError = NO;
    [_dataEmptyView removeFromSuperview];
    [_dataNotFoundView removeFromSuperview];
}

//to be overwrite
- (void)stopLoading{
}

// 主要是方便子类重写
// 这里的设计有缺陷，如何支持二维数组数据结构？？？？？
- (id)dataAtIndexPath:(NSIndexPath *)indexPath{
    return [self.dataSource dataObjectAtIndexPath:indexPath];
}


#pragma datasource delegate

- (void)dataSourceWillLoading:(OllaDataSource *)dataSource{
    [super dataSourceWillLoading:dataSource];
    [self startLoading];
}

- (void)dataSourceDidLoaded:(OllaDataSource *)dataSource{
    [super dataSourceDidLoaded:dataSource];
    
    self.dataLoadingError = NO;
    [self stopLoading];
}

- (void)dataSource:(OllaDataSource *)dataSource didFitalError:(NSError *)error{
    self.dataLoadingError = YES;
    [self stopLoading];
    [super dataSource:dataSource didFitalError:error];
}

@end
