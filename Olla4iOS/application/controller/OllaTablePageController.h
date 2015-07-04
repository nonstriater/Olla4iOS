//
//  OllaTablePageController.h
//  OllaFramework
//
//  Created by null on 14-9-8.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaTableDataController.h"

//刷新和分页加载
@interface OllaTablePageController : OllaTableDataController

@property(nonatomic,strong) IBOutlet UIControl<IOllaRefreshView> *topRefreshView;

@property(nonatomic,strong) IBOutlet UITableViewCell<IOllaLoadingMoreView> *bottomLoadingView;

@property(nonatomic,assign) BOOL refreshViewEnable;

@property(nonatomic,assign) BOOL pageEnabled; // 数据显示分页，default YES


// 子类重写，做自己的业务逻辑
- (void)tableViewRefreshTrigger:(UIControl<IOllaRefreshView> *)refreshView;

- (void)tableViewHaveScrollToBottom;

// 为子类实现其他的tableController 重写（如gridPlaza）
- (BOOL)addBottomLoadingViewAtIndexPath:(NSIndexPath *)indexPath;

@end
