//
//  IOllaUIContext.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IOllaContext.h"

@protocol IOllaUIContext <IOllaContext>

/**
 *  方便跟踪当前到了哪一个viewcontroller
 */
@property(nonatomic,weak) UIViewController *currentViewController;

/**
 *默认urlkey=@"url"
 */
- (id)rootViewController;

/**
 *  在rootViewController不固定时使用，如可能是guide页，可能是登录也，也可能是首页
 *
 *  @param key  config.plist中的url key
 *
 *  @return rootViewController
 */
- (id)rootViewControllerWithURLKey:(NSString *)key;


- (id)getViewController:(NSURL *)url basePath:(NSString *)basePath;

@end
