//
//  OllaDataBind.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-2.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OllaDataBindMode){
    OllaDataBindModeNoWay=0,
    OllaDataBindModeOneWay,
    OllaDataBindModeTwoWay
};

@interface OllaDataBind : NSObject

@property(nonatomic,copy) NSString *propertyKeyPath;
@property(nonatomic,copy) NSString *dataKeyPath;
@property(nonatomic,copy) NSString *secondDataKeyPath;//当第一个为空时，选第二个
@property(nonatomic,copy) NSString *value; // 也有直接给值的，如cornerRadius
@property(nonatomic,strong) IBOutletCollection(UIView) NSArray *views;

@property(nonatomic,copy) NSString *enabledKeyPath;
@property(nonatomic,copy) NSString *disabledKeyPath;

@property(nonatomic,strong) id targetNilValue;//值为空时的值
@property(nonatomic,copy) NSString *stringFormat;//@“%@元”
@property(nonatomic,strong) NSValueTransformer *convertor;
@property(nonatomic,assign) OllaDataBindMode mode;//KVO

- (void)applyDataBinding:(id)data;

@end
