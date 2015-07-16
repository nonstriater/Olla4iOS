//
//  OllaDataController.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OllaTask.h"
#import "OllaDataSource.h"

@interface OllaDataController : OllaTask<OllaDataSourceDelegate>

@property(nonatomic,strong) IBOutlet OllaDataSource *dataSource;

-(void) refreshData;

-(void) reloadData;

-(void) cancel;


@end


@protocol OllaDataControllerDelegate <NSObject>

@optional
-(void) dataControllerWillLoading:(OllaDataController *) controller;

-(void) dataControllerDidLoadedFromCache:(OllaDataController *) controller timestamp:(NSDate *) timestamp;

-(void) dataControllerDidLoaded:(OllaDataController *) controller;

-(void) dataController:(OllaDataController *) controller didFitalError:(NSError *) error;

-(void) dataControllerDidContentChanged:(OllaDataController *) controller;


@end


