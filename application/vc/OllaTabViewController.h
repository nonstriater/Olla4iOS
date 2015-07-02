//
//  OllaTabViewController.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-1.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaViewController.h"

// 自定义tabbar viewController
@interface OllaTabViewController : OllaViewController

@property(nonatomic,strong) IBOutlet UIView *contentView;
@property(nonatomic,strong) IBOutlet UIView *tabView;
@property(nonatomic,strong) IBOutlet UIImageView *tabBackgroundImageView;
@property(nonatomic,strong) IBOutletCollection(UIButton) NSArray *tabButtons;

@property(nonatomic,strong,readonly) UIViewController *selectedViewController;
@property(nonatomic,strong,readonly) UIButton *selectedTabButton;
@property(nonatomic,strong) NSArray *viewControllers;
@property(nonatomic,assign) NSUInteger selectedIndex;

- (IBAction)doTabAction:(id)sender;

@end
