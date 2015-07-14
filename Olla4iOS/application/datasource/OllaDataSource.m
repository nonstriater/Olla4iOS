//
//  OllaDataSource.m
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaDataSource.h"
#import "foundation.h"

@implementation OllaDataSource

@synthesize context = _context;
@synthesize delegate = _delegate;

@synthesize skipCached = _skipCached;
@synthesize dataChanged = _dataChanged;

- (void)viewLoaded{

}

-(void) refreshData{
    
    //[self.dataObjects removeAllObjects];// 在新数据下载后再清
    [self loadData];
}

-(void) loadData{
    
    _loading = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(dataSourceWillLoading:)]) {
        [_delegate dataSourceWillLoading:self];
    }
    
}

-(void) cancel{
    
    _loading = NO;
}


- (NSUInteger)numberOfSection{
    
    if (![self count]) {
        return 0;
    }
    
    NSObject *object = [self dataObjectAtIndex:0];
    if (![object isArray]) {
        return 1;
    }
    return [self count];
}

- (NSUInteger)numberOfCellsAtSection:(NSUInteger)section{
    
    id object = [self dataObjectAtIndex:section];
    if (![object isArray]) {
        return [self count];
    }
    
    return [(NSArray *)object count];
}


-(NSInteger) count{
    
    return [_dataObjects count];
}


-(NSMutableArray *)dataObjects{
    if (!_dataObjects) {
        _dataObjects = [[NSMutableArray alloc] init];
    }
    return _dataObjects;
}

- (id)dataObjectAtIndexPath:(NSIndexPath *)indexPath{

    id object = [self dataObjectAtIndex:indexPath.section];
    if (![object isArray]) {
        return [self dataObjectAtIndex:indexPath.row];
    }
    return [(NSArray *)object objectAtIndex:indexPath.row];
}


-(id) dataObjectAtIndex:(NSUInteger) index{
    
    if (index<[self count]) {
        return [_dataObjects objectAtIndex:index];
    }
    
    return nil;
}

- (BOOL)removeObjectAtIndex:(NSUInteger)index{
    
    if (index>=[self count]) {
        return NO;
    }
    [_dataObjects removeObjectAtIndex:index];
    return YES;
}

/**
 *  resutl.data
 *
 *  @param resultsData
 */
-(void) loadResultsData:(id) resultsData{
    
    id items = _dataKey ? [resultsData dataForKeyPath:_dataKey]:resultsData;
    if ([items isKindOfClass:[NSArray class]]) {
        [[self dataObjects] addObjectsFromArray:items];
        
    }else if([items isKindOfClass:[NSDictionary class]]){
        [[self dataObjects] addObject:[NSMutableDictionary dictionaryWithDictionary:items]];
    }
    
}

- (void)downlinkTaskDidLoadedFromCache:(id)cache timestamp:(NSDate *)timestamp{
    
    //    if (self.dataChanged) {
    //        [self.dataObjects removeAllObjects];
    //        [self loadResultsData:cache];
    //    }
    [self loadResultsData:cache];
    
    if ([_delegate respondsToSelector:@selector(dataSourceDidLoadedFromCache:timestamp:)]) {
        [_delegate dataSourceDidLoadedFromCache:self timestamp:timestamp];
    }
    
    // self.dataChanged = NO;
}

- (void)downlinkTaskDidLoaded:(id)data{
    _loaded = NO;
    [self loadResultsData:data];
    
    if (_delegate && [_delegate respondsToSelector:@selector(dataSourceDidLoaded:)]) {
        [_delegate dataSourceDidLoaded:self];
    }
    
    _loading = NO;
    _loaded = YES;
    //_skipCached = NO;
    //self.dataChanged = NO;
}

- (void)downlinkTaskDidFitalError:(NSError *)error{
    
    if ([_delegate respondsToSelector:@selector(dataSource:didFitalError:)]) {
        [_delegate dataSource:self didFitalError:error];
    }
    
    _loading = NO;
    _loaded = YES;
    
}



@end
