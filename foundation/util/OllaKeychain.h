//
//  OllaKeychain.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OllaKeychain : NSObject

+ (NSString *)passwordForService:(NSString *)service account:(NSString *)account error:(NSError **)error;

+ (BOOL)setPassword:(NSString *)password forService:(NSString *)service account:(NSString *)account error:(NSError **)error;

+ (BOOL)deletePasswordForService:(NSString *)service account:(NSString *)account error:(NSError **)error;



@end
