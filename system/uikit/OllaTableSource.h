//
//  OllaTableSource.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-2.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OllaTableSection.h"

@interface OllaTableSource : NSObject<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) IBOutletCollection(OllaTableSection) NSArray *sections;
@property(nonatomic,strong) IBOutlet UITableView *tableView;

@end




