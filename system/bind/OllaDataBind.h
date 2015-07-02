//
//  OllaDataBind.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-2.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OllaDataBind : NSObject

@property(nonatomic,strong) NSString *propertyKeyPath;
@property(nonatomic,strong) NSString *dataKeyPath;
@property(nonatomic,strong) IBOutletCollection(UIView) NSArray *views;

@property(nonatomic,strong) NSString *enabledKeyPath;
@property(nonatomic,strong) NSString *disabledKeyPath;

@property(nonatomic,strong) NSString *value; // 也有直接给值的，如cornerRadius

- (void)applyDataBinding:(id)data;

@end
