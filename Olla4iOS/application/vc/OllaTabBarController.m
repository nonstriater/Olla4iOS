//
//  OllaTabBarController.m
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaTabBarController.h"
#import "Olla4iOS.h"

@interface OllaTabBarController ()

@end

@implementation OllaTabBarController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.    
    
}

- (void)setConfig:(id)config{
    if (_config != config) {
        _config = config;
        
        NSArray *items = [config valueForKey:@"items"];
        NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithCapacity:4];
        for (id item in items) {
            if (![item isKindOfClass:[NSDictionary class]]) {
                return ;
            }
            
            id controller = [self.context getViewController:[NSURL URLWithString:item[@"url"]] basePath:@"/"];
            if (controller && [controller isKindOfClass:[UIViewController class]]) {
                if (item[@"title"]) {
                    [[controller tabBarItem] setTitle:item[@"title"]];
                }
                if (item[@"image"]) {
                    UIImage *normalImage = [UIImage imageNamed:item[@"image"]];
                    if (IS_IOS7) {
                        normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    }
                    [[controller tabBarItem] setImage:normalImage];
                    
                    NSString *selectImageName = item[@"selectedImage"];
                    if (!selectImageName) {
                        selectImageName = [item[@"image"] stringByAppendingString:@"_h"];
                    }
                    if (selectImageName) {
                        
                        if (IS_IOS7) {
                            UIImage *selectImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                            UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:item[@"title"] image:[UIImage imageNamed:item[@"image"]] selectedImage:selectImage];
                            
                            [controller setTabBarItem:barItem];
                        }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
                            [[controller tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:selectImageName] withFinishedUnselectedImage:normalImage];
#pragma clang diagnostic pop
                        }
                    }
                }
                
                [controller setParentController:self];
                [controller loadURL:[NSURL URLWithString:item[@"url"]] basePath:@"/" animated:NO];
                [viewControllers addObject:controller];
            }
            
        }
        
        [self setViewControllers:viewControllers];
        
    }

}

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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
