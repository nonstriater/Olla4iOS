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

@property(nonatomic,weak) IBOutlet UIView *footerView;
@property(nonatomic,weak) IBOutlet UIView *headerView;
@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property(nonatomic,strong) IBOutletCollection(UITableViewCell) NSMutableArray *headerCells;//方便应对“cell可消除”这样的需求
@property(nonatomic,strong) IBOutletCollection(UITableViewCell) NSArray *footerCells;

@property(nonatomic,strong) IBOutlet UIControl<IOllaRefreshView> *topRefreshView;
@property(nonatomic,assign) IBInspectable BOOL refreshViewEnable;
@property(nonatomic,assign) IBInspectable BOOL autoHeight;

/**
 *  cell 是否允许删除
 */
@property(nonatomic,assign) BOOL canCellDelete;

// 刷新触发，子类重写，做自己的业务逻辑
- (void)tableViewRefreshTrigger:(UIControl<IOllaRefreshView> *)refreshView;

//针对一个列表多种动态cell类型
- (NSString *)nibNameAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;


//必须要调用super，除非你知道意味着什么！！
- (void)configCell:(OllaTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;


@end


@class OllaTableViewCell;
@protocol IOllaAction;

@protocol OllaTableDataControllerDelegate
@optional

// cell上button事件处理
- (void)tableDataController:(OllaTableDataController *)controller cell:(OllaTableViewCell *)cell doAction:(id<IOllaAction>)action event:(UIEvent *)event;
// cell 选中事件处理
- (void)tableDataController:(OllaTableDataController *)controller didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end
