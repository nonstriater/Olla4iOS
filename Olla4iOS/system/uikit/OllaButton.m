//
//  OllaButton.m
//  OllaFramework
//
//  Created by nonstriater on 14-6-27.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaButton.h"

typedef void (^EventBlock)();

@interface OllaButton ()
@property(nonatomic,strong) EventBlock eventBlock;
@end

@implementation OllaButton

@synthesize actionName = _actionName;
@synthesize userInfo = _userInfo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

    CGRect area = CGRectInset(self.bounds, -self.expandMargin, -self.expandMargin);
    return CGRectContainsPoint(area, point);
}

- (void)performSelectorBlock:(void (^)())block forControlEvents:(UIControlEvents)controlEvents{
    
    self.eventBlock = block;
    [self addTarget:self action:@selector(action:) forControlEvents:controlEvents];

}

- (void)action:(UIButton *)button{

    self.eventBlock();
}

@end
