//
//  OllaTabDataController.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-1.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaTabDataController.h"

@interface OllaTabDataController (){

}

@end


@implementation OllaTabDataController

@synthesize selectedIndex = _selectedIndex;


-(id)selectedTabButton{
    
    if (_selectedIndex<[_tabButtons count]) {
        return [_tabButtons objectAtIndex:_selectedIndex];
    }
    return nil;
}

- (id)selectedController{
    if (_selectedIndex<[_controllers count]) {
        return [_controllers objectAtIndex:_selectedIndex];
    }
    return nil;
}

- (id)selectedContentView{
    if (_selectedIndex<[_contentViews count]) {
        return [_contentViews objectAtIndex:_selectedIndex];
    }
    return nil;

}

- (void)setContentViews:(NSArray *)contentViews{
    if (_contentViews != contentViews) {
        _contentViews = [contentViews sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2){
            
            UIView *view1 = (UIView *)obj1;
            UIView *view2 = (UIView *)obj2;
            
            if ([view1 tag]-[view2 tag]<0) {
                return NSOrderedAscending;
            }
            if ([view1 tag]-[view2 tag]>0) {
                return NSOrderedDescending;
            }
            return NSOrderedSame;
        }];
        for (UIView *view in _contentViews) {
            if ([view isKindOfClass:[UIView class]]) {
                [view setHidden:YES];
            }
        }
    }

}


-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    if (_selectedIndex != selectedIndex) {
        
        if ([[self delegate] respondsToSelector:@selector(tabDataController:selectedWillChange:)]) {
            [[self delegate] tabDataController:self selectedWillChange:selectedIndex];
        }
        
        _selectedIndex = selectedIndex;
        if (_segmentedControl) {
            _segmentedControl.selectedSegmentIndex = selectedIndex;
        }
        
        
        // tabbutton状态
        for (int index=0; index<[_tabButtons count]; index++) {
            UIButton *button = [_tabButtons objectAtIndex:index];
            button.enabled = (index==_selectedIndex);
        }
        
        
        //只显示当前的content view
        for (int index=0; index<[_contentViews count]; index++) {
            UIView *view = [_contentViews objectAtIndex:index];
            view.hidden = !(index==_selectedIndex);
        }
        
        if ([[self delegate] respondsToSelector:@selector(tabDataController:selectedDidChange:)]) {
            [[self delegate] tabDataController:self selectedDidChange:_selectedIndex];
        }
        
        
    }
    
}


- (IBAction)doTabAction:(id)sender{

    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        [self setSelectedIndex:[(UISegmentedControl *)sender selectedSegmentIndex]];
        
    }else if([sender isKindOfClass:[UIButton class]]){
        NSUInteger index = [_tabButtons indexOfObject:sender];
        if (index != NSNotFound) {
            [self setSelectedIndex:index];
        }
    }
    
}


- (void)setContext:(id<IOllaUIContext>)context{
    
    [super setContext:context];
    
    for (id controller in _controllers) {
        [controller setContext:context];
    }
}


@end
