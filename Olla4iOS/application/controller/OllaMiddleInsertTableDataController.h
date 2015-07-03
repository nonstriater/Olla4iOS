//
//  OllaMiddleInsertTableDataController.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-18.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaTableDataController.h"

// 旨在给出在tableview的中间插入cell的通用方案，如加广告等
// 这段逻辑会影响tableview的效率，因为cellforrow里多了一些判断，而需要在cell中间插cell的情况应该是少数，所以独立出来
// 业务层选择性的使用，这样就比较好

@interface OllaMiddleInsertTableDataController : OllaTableDataController{
    NSUInteger middleCellOffset;
}

@property(nonatomic,strong) IBOutletCollection(UITableViewCell) NSArray *middleCells;// 应对插在中间的cell的需求，如广告，需要知道插入的indexPath.row;
@property(nonatomic,strong) NSArray *middleIndexRows;// 这个必须制定,且个数与[middeleCells count] 相等，否则，tableview布局会异常;eg. @[@2,@4],还要考虑数据源不足的情况

- (id)dataObjectAtSelectIndexRow:(NSUInteger)row;


@end
