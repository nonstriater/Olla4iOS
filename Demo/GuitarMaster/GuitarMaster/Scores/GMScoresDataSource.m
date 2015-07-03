//
//  GMScoresDataSource.m
//  GuitarMaster
//
//  Created by null on 15/5/27.
//  Copyright (c) 2015年 nonstriater. All rights reserved.
//

#import "GMScoresDataSource.h"

@implementation GMScoresDataSource

- (void)loadData{
    [super loadData];
    
    NSMutableArray *datas = [NSMutableArray arrayWithObject:@(1) count:20];
    [self downlinkTaskDidLoaded:datas forTaskType:nil];
    
}

@end
