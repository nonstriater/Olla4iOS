//
//  OllaViewController.m
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaViewController.h"
#import "IOllaAction.h"
#import "IOllaController.h"
#import "Olla4iOS.h"

@interface OllaViewController ()

@end

@implementation OllaViewController

@synthesize controllers = _controllers;
@synthesize context = _context;
@synthesize config = _config;
@synthesize url = _url;
@synthesize params = _params;
@synthesize alias = _alias;
@synthesize scheme = _scheme;
@synthesize parentController = _parentController;
@synthesize dataBindContainer = _dataBindContainer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   
#ifdef __IPHONE_7_0
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//        [self setEdgesForExtendedLayout:UIRectEdgeNone];
//    }
#endif
    
    //这里的controller可以使 ollaController，ollaDataSource
    for (id controller in _controllers) {
        if ([controller respondsToSelector:@selector(setContext:)]) {
            [controller setContext:self.context];
            if ([controller respondsToSelector:@selector(viewLoaded)]) {
                [controller viewLoaded];//可以在controller里面做一些初始化view的工作
            }
        }
    }
    
    [self applyDataBinding];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"view did load:%@ ====== shell.currentVC=%@",self.url,self);
    [self.context setCurrentViewController:self];
}


- (void)setConfig:(id)config{
    if (_config != config) {
        _config = config;
        
        id value = [_config valueForKey:@"title"];
        if (!value) {
            return;
        }
        if ([value isString]) {
            self.title = (NSString *)value;
        }else{
            DDLogError(@"%@'s title must be NSString type,check the config.plist",self);
        }
    }
}

- (void)applyDataBinding{

    [_dataBindContainer applyDataBinding:self];
}

- (IBAction)doAction:(id)sender{

    if ([sender conformsToProtocol:@protocol(IOllaAction) ]) {
        NSString *actionName = [sender actionName];
        id userInfo = [sender userInfo];
        if ([actionName isEqualToString:@"url"]) {
            if (userInfo && [userInfo isKindOfClass:[NSString class]]) {
                [self openURL:[NSURL URLWithString:userInfo relativeToURL:self.url] animated:YES];
            }
            
        }else if([actionName isEqualToString:@"openURL"]){
            if (userInfo && [userInfo isKindOfClass:[NSString class] ]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:userInfo]];
            }
        }
    }

}

- (NSString *)loadURL:(NSURL *)url basePath:(NSString *)basePath animated:(BOOL)animation{

    return [basePath stringByAppendingPathComponent:self.alias];
}

- (NSString *)loadURL:(NSURL *)url basePath:(NSString *)basePath params:(id)params animated:(BOOL)animation{
    return nil;
}



-(BOOL)canOpenURL:(NSURL *)url{
    
    
    return NO;
}

-(BOOL)openURL:(NSURL *)url animated:(BOOL)animation{
    
    return [self openURL:url params:nil animated:animation];
    
}

-(BOOL)openURL:(NSURL *)url params:(id)params animated:(BOOL)animation{
    
    NSString *scheme = [url scheme];
    if ([scheme isEqualToString:@"pop"]) {
    
        
    }else if([scheme isEqualToString:@"present"]){
    
        NSString *path = [url firstPathComponentRelativeTo:@"/"];
        if ([path length]==0) {//dismiss
            [self dismissViewControllerAnimated:animation completion:nil];
            return YES;
        }
        
        if ([url.host length] == 0 ) {
            
            id modalViewController = self;
            while ([modalViewController presentedViewController]) {
                modalViewController = [modalViewController presentedViewController];
            }
            
            id presentingViewController = [self.context getViewController:url basePath:@"/"];
            if ([presentingViewController conformsToProtocol:@protocol(IOllaUIViewController)]) {
                [(id<IOllaUIViewController>)presentingViewController setParams:params];
            }
            if (presentingViewController) {
                [presentingViewController loadURL:url basePath:@"/" animated:animation];
                [modalViewController presentViewController:presentingViewController animated:animation completion:nil];
                return YES;
            }
        }
        
    }
    
    return [_parentController openURL:url params:params animated:animation];
}

-(void)dealloc{
    
    NSLog(@"~~~~~~~~Dealloc:%@",self);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
