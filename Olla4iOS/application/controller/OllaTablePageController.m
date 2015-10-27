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
    
    NSUInteger count = [super tableView:tableView numberOfRowsInSection:section];
    if (section==[self.dataSource numberOfSection]-1) {//最后一个section加loadingMore
        count += 1;
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = 0.f;
    // loadingMore
    if ([self addBottomLoadingViewAtIndexPath:indexPath]) {
        height = self.bottomLoadingView.frame.size.height;
    }else{
        height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
        
    }
 
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self addBottomLoadingViewAtIndexPath:indexPath]) {//bottom more
        return self.bottomLoadingView;
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (BOOL)addBottomLoadingViewAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == [self.dataSource numberOfSection]-1 &&
        indexPath.row == (indexPath.section?0:[self.headerCells count]) + [self.dataSource numberOfCellsAtSection:indexPath.section] ) {
        return YES;
    }
    
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self addBottomLoadingViewAtIndexPath:indexPath]) {
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
