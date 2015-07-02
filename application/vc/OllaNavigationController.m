//
//  OllaNavigationController.m
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaNavigationController.h"
#import "foundation.h"

@interface OllaNavigationController ()

@end

@implementation OllaNavigationController

@synthesize context = _context;
@synthesize config = _config;
@synthesize url = _url;
@synthesize params = _params;
@synthesize alias = _alias;
@synthesize scheme = _scheme;
@synthesize controllers = _controller;
@synthesize parentController = _parentController;

//@synthesize dataBindContainer = _dataBindContainer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setConfig:(id)config{
    
    if (_config != config) {
        _config = config;
        
        id value = [_config valueForKey:@"navbar-hidden"];
        if (value) {
            [self setNavigationBarHidden:[value boolValue] animated:NO];
        }
    }

}


- (BOOL)canOpenURL:(NSURL *)url{

    return NO;
}

- (BOOL)openURL:(NSURL *)url animated:(BOOL)animation{
    return [self openURL:url params:nil animated:YES];
}

- (BOOL)openURL:(NSURL *)url params:(id)params animated:(BOOL)animation{
    
    [self loadURL:url basePath:@"/" params:params animated:YES];
    
//    NSString *scheme = self.scheme;
//    if (scheme==nil) {
//        scheme = @"nav";
//    }
//    if ([[url scheme] isEqualToString:scheme]) {//eg. login
//        [self loadURL:url basePath:@"/" params:params animated:YES];
//        return YES;
//    }
    
    return NO;
}

- (NSString *)loadURL:(NSURL *)url basePath:(NSString *)basePath animated:(BOOL)animation{
    
    return [self loadURL:url basePath:basePath params:nil animated:animation];
}


- (NSString *)loadURL:(NSURL *)url basePath:(NSString *)basePath params:(id)params animated:(BOOL)animation{

    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    NSMutableArray *newViewControlers = [[NSMutableArray alloc] init];
    basePath = [basePath stringByAppendingPathComponent:self.alias];
    NSString *path = [url firstPathComponentRelativeTo:basePath];

    while (path) {
        
        if ([viewControllers count]>0) {
            id<IOllaUIViewController> viewController = viewControllers[0];
            if ([path isEqualToString:viewController.alias]) {
                basePath = [viewController loadURL:url basePath:basePath animated:animation];
                [newViewControlers addObject:viewController];
                [viewControllers removeObject:viewController];
            }
            
        }else{
        
            id<IOllaUIViewController> viewController = [self.context getViewController:url basePath:basePath];
            NSAssert(viewController!=nil,@"如果viewContrlller为nil，会造成死循环崩溃");
            // 这里如果viewContrlller为nil，会造成死循环崩溃
            // olla:///root/tab/setting 误写成 olla://root/tab/setting 也会死循环
            // edit-profile误写为edit，也会死循环
            if (viewController) {
                basePath = [viewController loadURL:url basePath:basePath animated:animation];
                viewController.parentController = self;
                viewController.params = params;
                [newViewControlers addObject:viewController];
            }
            
        }
        
        path = [url firstPathComponentRelativeTo:basePath];
    }
    
    [self setViewControllers:newViewControlers animated:animation];
    
    return basePath;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
