//
//  IOllaDownlinkTask.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IOllaDownlinkTask

@property(nonatomic,assign,getter = isSkipCached) BOOL skipCached;
@property(nonatomic,assign,getter = isDataChanged) BOOL dataChanged;

@optional
- (void)downlinkTaskDidLoadedFromCache:(id)cache timestamp:(NSDate *)timestamp forTaskType:(Protocol *)taskType;

- (void)downlinkTaskDidLoaded:(id)data forTaskType:(Protocol *)taskType;
- (void)downlinkTaskDidFitalError:(NSError *)error forTaskType:(Protocol *)taskType;

@end
