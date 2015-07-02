//
//  NSLocale+additions.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-10.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSLocale (additions)

+ (NSArray *)allCountries;// identifier default @"en_US"
+ (NSArray *)languagesWithIdentifier:(NSString *)identifier;
+ (NSArray *)countriesWithIdentifier:(NSString *)identifier;

/**
 *
 *
 *  @param identifier  地区码，格式是：语言码_国家码  eg. en_US, zh_CN, fr_FR
 *  @param flag       是否带国旗信息
 *
 *  @return   @{country, code}
 */
+ (NSArray *)countriesWithIdentifier:(NSString *)identifier flag:(BOOL)flag;//带国旗,每一项是dictionary  , 一个helper api ，方便显示国旗用

// identifier 默认为@“en_US”
+ (NSString *)countryCodeWithName:(NSString *)countryName;

/**
 *
 *
 *  @param countryName 国家名字
 *  @param identifier  同上
 *
 *  @return 返回country code
 */
+ (NSString *)countryCodeWithName:(NSString *)countryName inIdentifier:(NSString *)identifier;

@end
