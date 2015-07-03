//
//  OllaDescendTableDataController.h
//  OllaFramework
//
//  Created by nonstriater on 14/8/27.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaTablePageController.h"

// 管理一个倒序的tableView，适合IM页面这种业务需求的展现
// 不支持有headcells
@interface OllaDescendTableDataController : OllaTablePageController


- (void)tableViewScrollToBottomAnimated:(BOOL)animated;

@end
