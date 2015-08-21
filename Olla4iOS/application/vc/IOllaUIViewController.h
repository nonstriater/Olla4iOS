//
//  IOllaUIViewController.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IOllaUIContext.h"
#import "OllaDataBindContainer.h"

@protocol IOllaUIViewController <NSObject>

@property(nonatomic, weak) id<IOllaUIContext> context;
@property(nonatomic, strong) id config;
@property(nonatomic, strong) NSURL *url;
@property(nonatomic,strong) NSString *alias;
@property(nonatomic,strong) NSString *scheme;
@property(nonatomic,weak) id parentController;//used for container ViewController

//写这里，xib中iboulet变量老出不来
//@property(nonatomic,strong) IBOutlet OllaDataBindContainer *dataBindContainer;

- (BOOL)canOpenURL:(NSURL *)url;
- (BOOL)openURL:(NSURL *)url animated:(BOOL)animation;

/**
 *  给openURL扩展一个方法
 - openURL:params:animated //params是一个id类型，可以传递model类型的参数！！这样可以避免页面之间需要传递字典，数组这一类的数据时的拼装和解析！！
 */
@property(nonatomic,strong) id params;
- (BOOL)openURL:(NSURL *)url params:(id)params animated:(BOOL)animation;


// OllaViewController,OllaNavagationController,OllaTabBarController 有不同的
- (NSString *)loadURL:(NSURL *)url basePath:(NSString *)basePath animated:(BOOL)animation;
- (NSString *)loadURL:(NSURL *)url basePath:(NSString *)basePath params:(id)params animated:(BOOL)animation;


@end
