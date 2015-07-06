//
//  OllaButton.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-27.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IOllaAction.h"

@interface OllaButton : UIButton<IOllaAction>

@property(nonatomic,assign) CGFloat expandMargin;//default 0;

- (void)performSelectorBlock:(void (^)())block forControlEvents:(UIControlEvents)controlEvents;

@end
