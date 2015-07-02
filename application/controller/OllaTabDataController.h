//
//  OllaTabDataController.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-1.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaDataController.h"

@interface OllaTabDataController : OllaDataController{
@protected
    NSUInteger _selectedIndex;
}

@property(nonatomic,strong) IBOutletCollection(OllaDataController) NSArray *controllers;
@property(nonatomic,strong) IBOutletCollection(UIButton) NSArray *tabButtons;
@property(nonatomic,strong) IBOutlet UISegmentedControl *segmentedControl;
@property(nonatomic,strong) IBOutletCollection(UIView) NSArray *contentViews;

@property(nonatomic,strong,readonly) id selectedController;
@property(nonatomic,strong,readonly) id selectedTabButton;
@property(nonatomic,strong,readonly) id selectedContentView;

@property(nonatomic,assign) NSUInteger selectedIndex;


- (IBAction)doTabAction:(id)sender;

@end



@protocol OllaTabDataControllerDelegate <NSObject>

@optional
- (BOOL)tabDataController:(OllaTabDataController *)controller selectedWillChange:(NSUInteger)selectedIndex;
- (BOOL)tabDataController:(OllaTabDataController *)controller selectedDidChange:(NSUInteger)selectedIndex;


@end







