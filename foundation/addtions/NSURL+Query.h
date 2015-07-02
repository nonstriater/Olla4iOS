//
//  NSURL+Query.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-22.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Query)

@property(nonatomic,strong,readonly) NSDictionary *queryValue;

- (NSString  *)urlPath; // host+path

- (NSDictionary *)queryValues;

- (NSURL *)URLByAppendingPathComponent:(NSString *)string queryValue:(NSDictionary *)queryValue;

+ (NSURL *)URLWithString:(NSString *)string queryValue:(NSDictionary *)queryValue;

+ (NSURL *)URLWithString:(NSString *)string relativeToURL:(NSURL *)baseURL queryValues:(NSDictionary *)query;

- (NSString *)firstPathComponent;

- (NSString *)firstPathComponentRelativeTo:(NSString *)basePath;

@end
