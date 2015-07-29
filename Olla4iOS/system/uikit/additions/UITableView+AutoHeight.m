//
//  UITableView+AutoHeight.m
//  Olla4iOSDemo
//
//  Created by null on 15/7/29.
//  Copyright (c) 2015年 nonstriater. All rights reserved.
//

#import "UITableView+AutoHeight.h"
#import "objc/runtime.h"

@implementation UITableView (AutoHeight)

- (void)setAutoHeight:(BOOL)autoHeight{
    objc_setAssociatedObject(self, _cmd, @(autoHeight), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)autoHeight{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
