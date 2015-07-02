//
//  OllaDescendTableDataController.m
//  OllaFramework
//
//  Created by nonstriater on 14/8/27.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaDescendTableDataController.h"
#import "OllaPageDataSource.h"

@implementation OllaDescendTableDataController


- (void)tableViewScrollToBottomAnimated:(BOOL)animated{
    if ([self.dataSource count]) {
        NSInteger pageSize = [(OllaPageDataSource *)self.dataSource pageSize];
        NSInteger pageIndex = [(OllaPageDataSource *)self.dataSource pageIndex];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataSource count]-(pageIndex-1)*pageSize inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
    
}

- (void)dataSourceDidLoaded:(OllaDataSource *)dataSource{
    [super dataSourceDidLoaded:dataSource];

    [self tableViewScrollToBottomAnimated:NO];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 ) {// loadingMore
        return self.bottomLoadingView.frame.size.height;
    }
    return tableView.rowHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"indexPath row = %ld",(long)indexPath.row);
    
    if (indexPath.row == 0) {//bottom more
        return self.bottomLoadingView;
    }
    
    //itemViewNib空会崩溃
    NSAssert([self.itemViewNib length], @"itemViewNib空会崩溃");
    id data = [self dataAtIndexPath:indexPath];
    NSString *reuseIdentifier=nil;
    NSString *nibName = self.itemViewNib;
    
    if (!reuseIdentifier) {
        reuseIdentifier = self.itemViewNib;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[OllaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier nibName:nibName];
    }
    
    if ([cell isKindOfClass:[OllaTableViewCell class]]) {
        [(OllaTableViewCell *)cell setDelegate:self];// 代理cell上的button event
        [(OllaTableViewCell *)cell setDataItem:data];
    }
    
    return cell;
}



@end
