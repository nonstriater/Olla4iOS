//
//  OllaPreference.h
//  Olla
//
//  Created by null on 14-10-18.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OllaPreference : NSObject

@property(nonatomic,copy) NSString *uid;
@property(nonatomic,copy) NSString *fullNamespace;
@property(nonatomic,copy) NSString *path;//文件存储路径

+ (OllaPreference *)defaultInstance;

- (id)valueForKey:(NSString *)defaultName;
- (void)setValue:(id)value forKey:(NSString *)defaultName;
- (void)addUserInfo:(NSDictionary *)userInfo;
- (void)removeValueForKey:(NSString *)defaultName;

- (BOOL)synchronize;

@end
