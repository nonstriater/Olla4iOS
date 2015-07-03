//
//  OllaScrollTabDataController.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-1.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaScrollTabDataController.h"

@implementation OllaScrollTabDataController

-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    [self setSelectedIndex:selectedIndex animated:NO];

}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated{
    [self setSelectedIndex:selectedIndex animated:animated needScroll:YES];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated needScroll:(BOOL)needScroll{
    
    if ([[self delegate] respondsToSelector:@selector(tabDataController:selectedWillChange:)]) {
        [[self delegate] tabDataController:self selectedWillChange:self.selectedIndex];
    }
    
    _selectedIndex = selectedIndex;
    
    for (int index=0; index<[self.tabButtons count]; index++) {
        UIButton *button = [self.tabButtons objectAtIndex:index];
        button.enabled = (index==_selectedIndex);
    }
    
    //只显示当前的content viewxxxxx 用scrollview了
    if (needScroll) {
        [_scrollView setContentOffset:CGPointMake(_selectedIndex*CGRectGetWidth(_scrollView.bounds),0) animated:animated];
    }
    
    if ([[self delegate] respondsToSelector:@selector(tabDataController:selectedDidChange:)]) {
        [[self delegate] tabDataController:self selectedDidChange:_selectedIndex];
    }
    
}



// //////////////////////////////////////////////////////////////////////////////////

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
       [self setSelectedIndex:scrollView.contentOffset.x/CGRectGetWidth(scrollView.bounds) animated:NO needScroll:NO];
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self setSelectedIndex:scrollView.contentOffset.x/CGRectGetWidth(scrollView.bounds) animated:NO needScroll:NO];
}




@end
