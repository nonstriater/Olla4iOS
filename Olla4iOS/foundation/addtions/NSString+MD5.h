//
//  NSString+MD5.h
//  FuShuo
//
//  Created by nonstriater on 14-1-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)


- (NSString *)URLEncode;
- (NSString *)encodeURLStringByAddingEscapteString;
- (NSString *)decodeURLStringByAddingEscapteString;


- (NSString *)md5Encode;
- (NSString *)SHA1Encode;

// base64 string  ---> data , 兼容iOS6
- (NSData *)base64Decode;

- (NSString *)AESEncodeUsingKey:(NSString *)key;
- (NSString *)AESDecodeUsingKey:(NSString *)key;

@end
