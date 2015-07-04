//
//  OllaTableViewController.m
//  Olla4iOSDemo
//
//  Created by null on 15/7/4.
//  Copyright (c) 2015年 nonstriater. All rights reserved.
//

#import "OllaTableViewController.h"
#import "Olla4iOS.h"

@implementation OllaTableViewController

@synthesize controllers = _controllers;
@synthesize context = _context;
@synthesize config = _config;
@synthesize url = _url;
@synthesize params = _params;
@synthesize alias = _alias;
@synthesize scheme = _scheme;
@synthesize parentController = _parentController;
@synthesize dataBindContainer = _dataBindContainer;


- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self applyDataBinding];
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


// xib url ////////////////////////////

-(BOOL)canOpenURL:(NSURL *)url{
    return NO;
}


- (BOOL)openURL:(NSURL *)url animated:(BOOL)animation{
    return [self openURL:url params:nil animated:animation];
}

- (BOOL)openURL:(NSURL *)url params:(id)params animated:(BOOL)animation{
    
    return [_parentController openURL:url params:params animated:animation];
}


- (NSString *)loadURL:(NSURL *)url basePath:(NSString *)basePath animated:(BOOL)animation{
    
    return [basePath stringByAppendingPathComponent:self.alias];
}

- (NSString *)loadURL:(NSURL *)url basePath:(NSString *)basePath params:(id)params animated:(BOOL)animation{
    
    return nil;
}




@end
