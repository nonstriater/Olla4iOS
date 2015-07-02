//
//  OllaSandBox.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-23.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OllaSandBox : NSObject

+ (NSString *)appPath;
+ (NSString *)documentPath;
+ (NSString *)libraryPath;
+ (NSString *)libPrefPath;
+ (NSString *)libCachePath;
+ (NSString *)tmpPath;

+ (BOOL)createPathIfNotExist:(NSString *)path;
+ (BOOL)createFileIfNotExist:(NSString *)path;
+ (BOOL)deleteItem:(NSString *)path;
+ (BOOL)copyItem:(NSString *)srcPath toPath:(NSString *)destPath;

@end
