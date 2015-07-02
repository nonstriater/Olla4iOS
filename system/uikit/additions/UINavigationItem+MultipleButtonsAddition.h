//
//  UINavigationItem+MultipleButtonsAddition.h
//  EverPhoto
//
//  Created by null on 15-5-8.
//  Copyright (c) 2015年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (MultipleButtonsAddition)

@property (nonatomic, strong) IBOutletCollection(UIBarButtonItem) NSArray* rightBarButtonItemsCollection;
@property (nonatomic, strong) IBOutletCollection(UIBarButtonItem) NSArray* leftBarButtonItemsCollection;

@end
