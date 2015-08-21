//
//  OllaViewController.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IOllaUIViewController.h"
#import "OllaDataController.h"

@interface OllaViewController : UIViewController<IOllaUIViewController>

@property(nonatomic,strong) IBOutlet OllaDataBindContainer *dataBindContainer;

/**
 * 每个VC都可以配置一个Controller来分离部分逻辑
 */
@property(nonatomic,strong) IBOutlet OllaDataController *controller;


- (IBAction)doAction:(id)sender;
- (void)applyDataBinding;

@end
