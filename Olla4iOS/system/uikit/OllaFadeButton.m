//
//  OllaFadeButton.m
//  Olla
//
//  Created by null on 15-1-29.
//  Copyright (c) 2015年 xiaoran. All rights reserved.
//

#import "OllaFadeButton.h"

@interface OllaFadeButtonLayer : CALayer
@end

@implementation OllaFadeButtonLayer

- (id<CAAction>)actionForKey:(NSString *)event{
    if ([event isEqualToString:@"contents"] && self.contents==nil) {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.25f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        return transition;
    }
    
    return nil;
}

@end



@implementation OllaFadeButton

- (CALayer *)layer{
    return [OllaFadeButtonLayer layer];
}

@end
