//
//  OllaDataBindContainer.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-2.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaDataBindContainer.h"

@implementation OllaDataBindContainer

- (void)applyDataBinding:(id)data{
    for (OllaDataBind *dataBind in _dataBindings) {
        [dataBind applyDataBinding:data];
    }

}


@end
