//
//  LLResignView.m
//  Olla
//
//  Created by null on 14-11-4.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaResignView.h"
#import "UIView+Gesture.h"

@implementation OllaResignView


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitial];
    }
    return self;
}

- (void)awakeFromNib{
    [self commonInitial];
}

- (void)commonInitial{
    
    [self tap:^(UITapGestureRecognizer *tapGesture) {
       
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
        
    }];
    
}



@end
