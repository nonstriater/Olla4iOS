//
//  OllaTabViewController.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-1.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaTabViewController.h"

@interface OllaTabViewController ()

@end

@implementation OllaTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// /////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (animated) {
        UIViewController *viewController = [self  selectedViewController];
        [viewController viewWillAppear:animated];
        
        [self addChildViewController:viewController];
        [viewController.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth ];
        [viewController.view setFrame:_contentView.bounds];
        [_contentView addSubview:viewController.view];
        
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

// /////////////////////////////////////////////////////////////////////////////

- (UIViewController *)selectedViewController{

    if ([_viewControllers count]==0) {
        return nil;
    }
    
    if (_selectedIndex>=[_viewControllers count]) {
        _selectedIndex = 0;
    }

    return [_viewControllers objectAtIndex:_selectedIndex];
}

- (UIButton *)selectedTabButton{
    if ([_tabButtons count]==0 || _selectedIndex>=[_tabButtons count]) {
        return nil;
    }
    
    return [_tabButtons objectAtIndex:_selectedIndex];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    
    if ([_viewControllers count]==0 || _selectedIndex==selectedIndex) {
        return;
    }
    
    if (_selectedIndex>=[_viewControllers count]) {
        _selectedIndex = 0;
    }
    
    
    
    if ([self isViewLoaded]) {
        
       UIViewController *selectedViewController = [self selectedViewController];
        if ([selectedViewController isViewLoaded]) {
            if (selectedViewController.view.superview) {
                [selectedViewController viewWillDisappear:YES];
                [selectedViewController.view removeFromSuperview];
                [selectedViewController viewDidDisappear:YES];
                
            }
        }
        
    }
    
    _selectedIndex = selectedIndex;
    
    
    if ([self isViewLoaded]) {
        
        UIViewController *newSelectedViewController = [self selectedViewController];
        [newSelectedViewController.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [newSelectedViewController.view setFrame:_contentView.bounds];
        
        [newSelectedViewController viewWillAppear:YES];
        [_contentView addSubview:newSelectedViewController.view];
        [newSelectedViewController viewDidAppear:YES];
        
        
    }
    
    
    
    for (NSUInteger index=0;index<[_tabButtons count];index++) {
        
        UIButton *button = [_tabButtons objectAtIndex:index];
        [button setSelected:(index==_selectedIndex)];
    }

}


- (IBAction)doTabAction:(id)sender{

    if (sender != [self selectedTabButton]) {
        [self setSelectedIndex:[_tabButtons indexOfObject:sender]];
    }
}

// /////////////////////////////////////////////////////////////////////////////

- (void)setConfig:(id)config{

}

-(BOOL)canOpenURL:(NSURL *)url{
    return NO;
}

- (BOOL)openURL:(NSURL *)url animated:(BOOL)animation{

    return NO;
}


// /////////////////////////////////////////////////////////////////////////////

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
