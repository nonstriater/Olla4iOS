//
//  IOllaController.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IOllaUIController <NSObject>

@optional
- (void)viewDidLoad;
- (void)viewWillAppear;
- (void)viewDidLayoutSubviews;
- (void)viewWillDisappear;

@end
