//
//  OllaTableDataController.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaCollectionController.h"
#import "IOllaAction.h"
#import "OllaTableViewCell.h"
#import "OllaRefreshView.h"
#import "OllaLoadingMoreView.h"

// 用于一个table多个自定义cell的情况
@interface OllaTableCellItem : NSObject
@property(nonatomic,strong) NSString *nib;
@property(nonatomic,strong) NSString *reusableIdentifier;
@property(nonatomic,assign) id type; // 1 文字 2 图片 3 声音 4 新闻

@end

@interface OllaTableDataController : OllaCollectionController<UITableViewDelegate,UITableViewDataSource,OllaTableViewCellDelegate>

@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property(nonatomic,strong) IBOutletCollection(UITableViewCell) NSMutableArray *headerCells;//方便应对“cell可消除”这样的需求
@property(nonatomic,strong) IBOutletCollection(UITableViewCell) NSArray *footerCells;

@property(nonatomic,strong) NSArray *cellTypeGroup;//多种cell类型
@property(nonatomic,assign) BOOL canCellDelete;

//必须要调用super，除非你知道意味着什么！！
- (void)configCell:(OllaTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end


@class OllaTableViewCell;
@protocol IOllaAction;

@protocol OllaTableDataControllerDelegate
@optional

// cell上button事件处理
- (void)tableDataController:(OllaController *)controller cell:(OllaTableViewCell *)cell doAction:(id<IOllaAction>)action event:(UIEvent *)event;
// cell 选中事件处理
- (void)tableDataController:(OllaController *)controller didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end
