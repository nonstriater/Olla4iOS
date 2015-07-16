//
//  OllaController.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IOllaController.h"

@interface OllaTask : NSObject<IOllaController>

@property(nonatomic,weak) id<IOllaUIContext> context;
@property(nonatomic,weak) IBOutlet id delegate;
@property(nonatomic,assign) NSUInteger tag;

@end
