//
//  OllaTableViewController.h
//  Olla4iOSDemo
//
//  Created by null on 15/7/4.
//  Copyright (c) 2015年 nonstriater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IOllaUIViewController.h"
#import "OllaDataController.h"

@interface OllaTableViewController : UITableViewController<IOllaUIViewController>

/**
 * data & ui bind
 */
@property(nonatomic,strong) IBOutlet OllaDataBindContainer *dataBindContainer;

/**
 * 每个VC都可以配置一个Controller来分离部分逻辑
 */
@property(nonatomic,strong) IBOutlet OllaDataController *controller;

- (void)applyDataBinding;
- (IBAction)doAction:(id)sender;

@end
