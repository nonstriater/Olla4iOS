//
//  UITableViewCell+additions.m
//  Olla
//
//  Created by null on 14-11-5.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "UITableViewCell+additions.h"

@implementation UITableViewCell (additions)

@dynamic selectedBackgroundColor;

- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor{
    
    //bacgview is default nil for tableViewPlain ,not nil for group tableview 
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.backgroundColor = selectedBackgroundColor;
    self.selectedBackgroundView = backgroundView;
    
}

@end
