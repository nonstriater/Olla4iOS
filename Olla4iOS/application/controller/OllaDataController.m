//
//  OllaDataController.m
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaDataController.h"

@implementation OllaDataController


- (void)viewDidLoad{}
- (void)viewWillAppear{}
- (void)viewWillDisappear{}

- (void)dealloc{
    NSLog(@"%@ dealloc!",self);
}

-(void)setContext:(id<IOllaUIContext>)context{
    [super setContext:context];
    _dataSource.context = context;
}

-(void) refreshData{
    [_dataSource refreshData];
}

-(void) reloadData{
    [_dataSource loadData];
}

-(void) cancel{
    [_dataSource cancel];
}


#pragma mark datasource delegate

-(void) dataSourceWillLoading:(OllaDataSource *) dataSource{
    
    if (_dataSource == dataSource && [self.delegate respondsToSelector:@selector(dataControllerWillLoading:)]) {
        
        [self.delegate dataControllerWillLoading:self];
    }
}

-(void) dataSourceDidLoadedFromCache:(OllaDataSource *) dataSource timestamp:(NSDate *) timestamp{
    
    if (_dataSource == dataSource && [self.delegate respondsToSelector:@selector(dataControllerDidLoadedFromCache:timestamp:)]) {
        
        [self.delegate dataControllerDidLoadedFromCache:self timestamp:timestamp];
    }
}

-(void) dataSourceDidLoaded:(OllaDataSource *) dataSource{

    if (_dataSource == dataSource && [self.delegate respondsToSelector:@selector(dataControllerDidLoaded:)]) {
        
        [self.delegate dataControllerDidLoaded:self];
    }
}

-(void) dataSource:(OllaDataSource *) dataSource didFitalError:(NSError *) error{
    if (_dataSource == dataSource && [self.delegate respondsToSelector:@selector(dataController:didFitalError:)]) {
        
        [self.delegate dataController:self didFitalError:error];
    }
}

-(void) dataSourceDidContentChanged:(OllaDataSource *) dataSource{
    if (_dataSource == dataSource && [self.delegate respondsToSelector:@selector(dataControllerDidContentChanged:)]) {
        
        [self.delegate dataControllerDidContentChanged:self];
    }
}



@end
