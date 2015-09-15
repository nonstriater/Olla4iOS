//
//  OllaTablePageController.m
//  OllaFramework
//
//  Created by null on 14-9-8.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaTablePageController.h"
#import "OllaPageDataSource.h"
#import "Olla4iOS.h"

@implementation OllaTablePageController

- (id)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.pageEnabled = YES;
    return self;
}

- (void)stopLoading{
    
    [super stopLoading];
    if ([self.dataSource respondsToSelector:@selector(hasMoreData)]) {
        self.bottomLoadingView.hasMoreData = [(OllaPageDataSource *)self.dataSource hasMoreData];
    }
    [self.bottomLoadingView stopLoading];
}


// to be overwrite
- (void)tableViewHaveScrollToBottom{

}


-(UITableViewCell<IOllaLoadingMoreView> *)bottomLoadingView{
    if (!_bottomLoadingView) {// xib 中没有配置，使用代码配置
        _bottomLoadingView = [[OllaLoadingMoreView  alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    }
    return _bottomLoadingView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 如果[datasource count]为空,就不算middleCells
    NSUInteger dataSourceCount = [self.dataSource count];
    return [self.headerCells count]+ dataSourceCount + 1;// loadingMore
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == [self.headerCells count]+ [self.dataSource count] ) {// loadingMore
        return self.bottomLoadingView.frame.size.height;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self addBottomLoadingViewAtIndexPath:indexPath]) {//bottom more
        return self.bottomLoadingView;
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (BOOL)addBottomLoadingViewAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == [self.headerCells count]+ [self.dataSource count]) {
        return YES;
    }
    
    return NO;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == [self.headerCells count] + [self.dataSource count]) {
        return ;
    }
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];

}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (cell == self.bottomLoadingView) {
        
        if (![(OllaPageDataSource *)self.dataSource hasMoreData]) {
            [self tableViewHaveScrollToBottom];
            return;
        }
        
        if ( self.pageEnabled &&
            ![self.bottomLoadingView isLoading] &&
            [(OllaPageDataSource *)self.dataSource hasMoreData] &&
            ![self.dataSource isLoading]) {
            
            [self.bottomLoadingView startLoading];
            
            if ([self.dataSource respondsToSelector:@selector(loadMoreData)]) {
                [self.dataSource performSelector:@selector(loadMoreData) withObject:nil afterDelay:0.5f];
            }
        }
        
    }
    
}


@end
