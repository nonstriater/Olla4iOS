//
//  IOllaAction.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-27.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IOllaAction <NSObject>

@property(nonatomic,strong) NSString *actionName;
@property(nonatomic,strong) id userInfo;

@end
