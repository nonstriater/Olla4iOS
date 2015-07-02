//
//  NSArray+addtions.h
//  FuShuo
//
//  Created by nonstriater on 14-1-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (addtions)

+ (instancetype)arrayWithObject:(id)object count:(NSUInteger)cnt;

- (BOOL)isArray;
- (NSArray*)propertyListArray; // filter nsnull

@end
