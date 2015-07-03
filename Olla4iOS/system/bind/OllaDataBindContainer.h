//
//  OllaDataBindContainer.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-2.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OllaDataBind.h"

@interface OllaDataBindContainer : NSObject

@property(nonatomic,strong) IBOutletCollection(OllaDataBind) NSArray *dataBindings;

- (void)applyDataBinding:(id)data;

@end
