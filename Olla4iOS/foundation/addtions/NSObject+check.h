//
//  NSObject+check.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-17.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (check)

- (BOOL)isArray;
- (BOOL)isDictionary;
- (BOOL)isString;
- (BOOL)isNumber;
- (BOOL)isNull;
- (BOOL)isImage;
- (BOOL)isData;


- (BOOL)booleanValueForKey:(NSString *)key default:(BOOL)defaultValue;
-(BOOL) booleanValueForKey:(NSString *) key;

- (NSDictionary *)dictionaryRepresentation;
- (NSString *)JSONString;// 对象序列化，多用于存储, 字典调用

@end
