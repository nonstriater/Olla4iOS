//
//  NSDictionary+additions.h
//  FuShuo
//
//  Created by nonstriater on 14-1-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (additions)

- (BOOL)check;

// api中往往不欢迎nil的value,会导致崩溃
- (NSDictionary *)replaceNilValue;//it doesnot work!

- (NSMutableDictionary *)propertyListDictionary;
- (id)modelFromDictionaryWithClassName:(Class)clazz;
    
- (NSDictionary *)conversionWithModelMap:(NSDictionary *)map;

@end
