//
//  NSLocale+additions.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-10.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "NSLocale+additions.h"
#import "foundation.h"

@implementation NSLocale (additions)

+ (NSArray *)languagesWithIdentifier:(NSString *)identifier{
    NSMutableArray *unsortLanguages = [NSMutableArray array];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:identifier];
    for (NSString *code in [NSLocale ISOLanguageCodes]) {
        NSString *lang = [locale displayNameForKey:NSLocaleLanguageCode value:code];
        if (lang) {// 为nil会崩溃
            [unsortLanguages addObject:lang];
        }
        
    }
    
    return [unsortLanguages sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];

}


+ (NSArray *)countriesWithIdentifier:(NSString *)identifier{
    NSMutableArray *unsortCountries = [NSMutableArray array];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:identifier];
    for (NSString *code in [NSLocale ISOCountryCodes]) {
        NSString *country = [locale displayNameForKey:NSLocaleCountryCode value:code];
        [unsortCountries addObject:country];
    }
    
    return [unsortCountries sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

+ (NSArray *)countriesWithIdentifier:(NSString *)identifier flag:(BOOL)flag{

    NSMutableArray *unsortCountries = [NSMutableArray array];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:identifier];
    for (NSString *code in [NSLocale ISOCountryCodes]) {
        NSString *country = [locale displayNameForKey:NSLocaleCountryCode value:code];
        [unsortCountries addObject:@{@"country":country,@"code":code}];
    }
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"country" ascending:YES];
    return [unsortCountries sortedArrayUsingDescriptors:@[descriptor]];
}

+ (NSArray *)allCountries{
    NSArray *countries = [NSLocale countriesWithIdentifier:@"en_US" flag:YES];
    NSMutableArray *all = [NSMutableArray array];
    for (NSDictionary *item in countries) {
        /*
         {
         code = PS;
         country = "Palestinian Territories";
         }
         */
        NSString *c = item[@"country"];
        if (c) {
            [all addObject:c];
        }
    }
    return all;
}

+ (NSString *)countryCodeWithName:(NSString *)countryName{
    if (![countryName isString]) {
        return nil;
    }
    return [[self class] countryCodeWithName:countryName inIdentifier:@"en_US"];
}

+ (NSString *)countryCodeWithName:(NSString *)countryName inIdentifier:(NSString *)identifier{

    if (![countryName isString]) {
        return nil;
    }
    
    if (![identifier isString]) {
        return nil;
    }
    
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:identifier];
    for (NSString *code in [NSLocale ISOCountryCodes]) {
        if ([countryName isEqualToString:[locale displayNameForKey:NSLocaleCountryCode value:code]]) {////这里比较耗时
            return code;
        }
    }
    return nil;
}


@end
