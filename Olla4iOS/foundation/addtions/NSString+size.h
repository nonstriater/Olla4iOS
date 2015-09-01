//
//  NSString+size.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-16.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (size)

//计算字符串占据的size
- (CGSize)sizeWithFont:(UIFont *)font constrainedSize:(CGSize)size;

- (CGSize)sizeWithFont:(UIFont *)font constrainedSize:(CGSize)size numberOfLine:(NSUInteger)lines;

//判断是否含有字串，iOS8以后才添加了一个-containsString的方法
- (BOOL)containsSubString:(NSString *)string;

// 在64为机器上，string转为NSUInteger会调用该方法抛错
//- (NSUInteger)unsignedLongLongValue;

// 过滤掉字符串头部和尾部的空格
- (NSString *)escapeSpace;
- (NSString *)firstLetter;
- (NSString *)addEscapeSQLCharacters;//如果消息中又 “ ‘ 这样的字符会影响插入，需要加入转义字符
- (NSString *)removeEscapeSQLCharacters;
- (BOOL)isHTTPURL;

@end
