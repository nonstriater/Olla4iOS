//
//  OllaDataSource.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IOllaDownlinkTask.h"
#import "OllaTask.h"

@interface OllaDataSource : OllaTask<IOllaDownlinkTask>

@property(nonatomic,strong) NSMutableArray *dataObjects;

/**
 *   json数据中的key链  eg. result.data
 */
@property(nonatomic,strong) NSString *dataKey;

@property(nonatomic,assign,getter = isLoading) BOOL loading;
@property(nonatomic,assign,getter = isLoaded) BOOL loaded;
@property(nonatomic,readonly,getter = isEmpty) BOOL empty;

@property(nonatomic,assign) BOOL twod;//二维结构

- (void)refreshData;
- (void)loadData;
- (void)cancel;

- (void)loadResultsData:(id)resultsData;

- (NSInteger)count;

- (NSMutableArray *)dataObjects;


- (id)dataObjectAtIndex:(NSUInteger)index;
- (BOOL)removeObjectAtIndex:(NSUInteger)index;


- (NSUInteger)numberOfSection;
- (NSUInteger)numberOfCellsAtSection:(NSUInteger)section;
- (id)dataObjectAtIndexPath:(NSIndexPath *)indexPath;

@end



@protocol OllaDataSourceDelegate
@optional

-(void) dataSourceWillLoading:(OllaDataSource *) dataSource;
-(void) dataSourceDidLoadedFromCache:(OllaDataSource *) dataSource timestamp:(NSDate *) timestamp;
-(void) dataSourceDidLoaded:(OllaDataSource *) dataSource;
-(void) dataSource:(OllaDataSource *) dataSource didFitalError:(NSError *) error;
-(void) dataSourceDidContentChanged:(OllaDataSource *) dataSource;

@end



