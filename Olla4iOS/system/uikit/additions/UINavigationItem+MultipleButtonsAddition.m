//
//  UINavigationItem+MultipleButtonsAddition.m
//  EverPhoto
//
//  Created by null on 15-5-8.
//  Copyright (c) 2015年 bytedance. All rights reserved.
//

#import "UINavigationItem+MultipleButtonsAddition.h"

@implementation UINavigationItem (MultipleButtonsAddition)

- (void) setRightBarButtonItemsCollection:(NSArray *)rightBarButtonItemsCollection {
    self.rightBarButtonItems = [rightBarButtonItemsCollection sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:YES]]];
}

- (void) setLeftBarButtonItemsCollection:(NSArray *)leftBarButtonItemsCollection {
    self.leftBarButtonItems = [leftBarButtonItemsCollection sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:YES]]];
}

- (NSArray*) rightBarButtonItemsCollection {
    return self.rightBarButtonItems;
}

- (NSArray*) leftBarButtonItemsCollection {
    return self.leftBarButtonItems;
}


@end
