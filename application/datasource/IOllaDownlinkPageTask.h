//
//  IOllaDownlinkPageTask.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IOllaDownlinkTask.h"

@protocol IOllaDownlinkPageTask <IOllaDownlinkTask>

- (NSUInteger)downlinkPageTaskPageSize;
- (NSUInteger)downlinkPageTaskPageIndex;

@end
