//
//  NSMutableArray+addtions.m
//  OllaFramework
//
//  Created by nonstriater on 14-8-3.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "NSMutableArray+addtions.h"

@implementation NSMutableArray (addtions)

- (void)replaceObject:(id)oldObject withObject:(id)newObject{
    
    NSUInteger index = [self indexOfObject:oldObject];
    if (index != NSNotFound) {
        [self replaceObjectAtIndex:index withObject:newObject];
    }
}

@end
