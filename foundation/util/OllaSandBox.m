//
//  OllaSandBox.m
//  OllaFramework
//
//  Created by nonstriater on 14-6-23.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaSandBox.h"
#import "OllaFramework.h"

@implementation OllaSandBox

+ (NSString *)appPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    if ([paths count]>0) {
        return [paths objectAtIndex:0];
    }
    return nil;
    
}
//NSHomeDirectory()

+ (NSString *)documentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count]>0) {
        return [paths objectAtIndex:0];
    }
    return nil;
}
+ (NSString *)libraryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    if ([paths count]>0) {
        return [paths objectAtIndex:0];
    }
    return nil;
    
}
+ (NSString *)libPrefPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    if ([paths count]>0) {
        return [paths[0] stringByAppendingPathComponent:@"Preferences"];
    }
    return nil;
}
+ (NSString *)libCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    if ([paths count]>0) {
        return [paths[0] stringByAppendingPathComponent:@"Caches"];
    }
    return nil;
    
}

+ (NSString *)tmpPath{
    return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}


+ (BOOL)pathWithString:(NSString *)stringPath{

//    if ([stringPath hasPrefix:@"/"]) {
//        stringPath = [stringPath substringFromIndex:1];
//    }
//    NSArray *components = [stringPath componentsSeparatedByString:@"/"];
//    
//    NSMutableString *path = [NSMutableString stringWithString:@"/"];
//    for (int i=0; i<[components count]; i++) {
//        NSString *component = components[i];
//        [path stringByAppendingPathComponent:component];
//        if (i==[components count]-1) {
//            if (![OllaSandBox createFileIfNotExist:path]) {
//                return NO;
//            }
//        }
//        if (![OllaSandBox createPathIfNotExist:path]) {
//            return NO;
//        }
//    }

    return YES;
}

+ (BOOL)createPathIfNotExist:(NSString *)path;{

    if (NO==[[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error = nil;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (success && !error) {
            return YES;
        }else{
            DDLogError(@"CREATE Path fail:%@",error);
        }
        
    }
    return YES;
}

+ (BOOL)createFileIfNotExist:(NSString *)path{
    if (NO==[[NSFileManager defaultManager] fileExistsAtPath:path]) {
        // 如果path中又目录需要创建，先创建目录
        // 创建文件默认属性是只读的
        return [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    }
    return YES;
}


+ (BOOL)deleteItem:(NSString *)path{
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

+ (BOOL)copyItem:(NSString *)srcPath toPath:(NSString *)destPath{
    [self deleteItem:destPath];
    return [[NSFileManager defaultManager] copyItemAtPath:srcPath toPath:destPath error:nil];
}



@end
