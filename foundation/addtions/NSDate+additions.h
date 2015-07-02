//
//  NSDate+additions.h
//  FuShuo
//
//  Created by nonstriater on 14-1-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (additions)

/**
 * Formats dates within 24 hours like '5 minutes ago', or calls formatDateTime if older.
 */
- (NSString*)formatRelativeTime;


//yyyy-mm-dd
- (NSString *)formatToDayTime:(NSDateFormatter *)formatter;


//eg. 14:45 或 11月5 ,这里要用到NSDataFommater，从外部引入
- (NSString *)formatMouthRelativeTime:(NSDateFormatter *)formatter;

// yyyy-mm-dd hh-mm-ss
- (NSString *)timeWithFormatter:(NSDateFormatter *)formatter;


// 当天显示@"HH:mm"， 否则显示@"yyyy-MM-dd HH:mm"
- (NSString *)formatDetailRelativeTime;


//该日期在当天已经经过的s数
+ (NSTimeInterval)todayIntervalWithFormatter:(NSDateFormatter *)formatter;


//是否是当天时间
- (BOOL)isTodayWithFormatter:(NSDateFormatter *)formatter;

// 年份
- (NSString *)yearWithFormatter:(NSDateFormatter *)formatter;

//月份
- (NSString *)monthWithFormatter:(NSDateFormatter *)formatter;

// 日期
- (NSString *)dayWithFormatter:(NSDateFormatter *)formatter;


//所给日期于当前日期是否在同一天
- (BOOL)inSomeDay:(NSDate *)date withFormatter:(NSDateFormatter *)formatter;

//used for test
+ (NSDate *)random;
+ (NSDate *)randomBetweenYear:(NSUInteger)one andYear:(NSUInteger)two;



@end

