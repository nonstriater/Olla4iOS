//
//  OllaMiddleInsertTableDataController.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-18.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaMiddleInsertTableDataController.h"

@implementation OllaMiddleInsertTableDataController


- (void)setMiddleCells:(NSArray *)middleCells{
    if (_middleCells != middleCells) {
        _middleCells = middleCells;
        middleCellOffset = 0;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 如果[datasource count]为空,就不算middleCells
    NSUInteger dataSourceCount = [self.dataSource count];
        if (!dataSourceCount) {
            return [self.headerCells count];
        }
    return [self.headerCells count]+ dataSourceCount+[_middleCells count];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if ([_middleIndexRows containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
        return [[_middleCells objectAtIndex:[_middleIndexRows indexOfObject:[NSNumber numberWithInteger:indexPath.row]]] frame].size.height;
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

//调整好dataItems index,避免数据错位
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row<[[_middleIndexRows firstObject] intValue]) {
        middleCellOffset = 0;
        
    }else if(indexPath.row>[[_middleIndexRows lastObject] intValue]){
        middleCellOffset = [_middleIndexRows count];
    }else{// 升序数组中查找一个数，前面共有几个数
        int count=0;
        for (int i=0; i<[_middleIndexRows count]; i++) {
            if ([_middleIndexRows[i] intValue]<indexPath.row) {
                count++;
            }
        }
        middleCellOffset = count;
    }
    
    NSLog(@"row = %@, reset offset = %@",@(indexPath.row),@(middleCellOffset));
 
    if ([_middleIndexRows containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
        
        return [_middleCells objectAtIndex:[_middleIndexRows indexOfObject:[NSNumber numberWithInteger:indexPath.row]]];
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

// 重写
- (id)dataAtIndexRow:(NSInteger)row{
    return [self.dataSource dataObjectAtIndex:(row-[self.headerCells count]-middleCellOffset)];
}


- (id)dataObjectAtSelectIndexRow:(NSUInteger)row{
    
    NSUInteger offset = 0;

    if(row>[[_middleIndexRows lastObject] intValue]){
        offset = [_middleIndexRows count];
        
    }else{// 升序数组中查找一个数，前面共有几个数
        int count=0;
        for (int i=0; i<[_middleIndexRows count]; i++) {
            if ([_middleIndexRows[i] intValue]<row) {
                count++;
            }
        }
        offset = count;
    }

     return [self.dataSource dataObjectAtIndex:(row-[self.headerCells count]-offset)];
}



@end
