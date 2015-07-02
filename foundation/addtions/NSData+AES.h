//
//  NSData+AES.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)

// iOS7上又base64Encoding api直接调用，这里兼容iOS6处理
- (NSString *)base64Encode;

- (NSString *)md5Encode;

- (NSData *)AES256EncodeWithKey:(NSString *)key;
- (NSData *)AES256DecodeWithKey:(NSString *)key;


@end
