//
//  UIView+style.m
//  OllaFramework
//
//  Created by nonstriater on 14-8-13.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "UIView+style.h"
#import "Olla4iOS.h"

@implementation UIView (style)

@dynamic bgColor;
@dynamic borderWidth;
@dynamic borderColor;
@dynamic blurRadius;

- (UIView *)instanceWithStyle:(NSString *)style{
    
    NSObject *styleInfo =  [[OllaStyleParser sharePareser].styles valueForKey:style];
    if (![styleInfo isDictionary]) {
        return nil;
    }
    UIView *instance = [[[self class] alloc] init];
    for (NSString *key in [(NSDictionary *)styleInfo allKeys]) {
        @try {
            [instance setValue:[styleInfo valueForKey:key] forKey:key];
        }
        @catch (NSException *exception) {
            NSLog(@"%@ class has no property of %@",[instance class],key);
            continue;
        }
        @finally {
            
        }
    }
    
    return instance;
}


- (void)setBgColor:(NSString *)bgColor{// #333322
    
    if ([bgColor isEqualToString:@"red"]) {
        self.backgroundColor = [UIColor redColor];
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    [self.layer setBorderWidth:borderWidth];
}


-(CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}

-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBlurRadius:(CGFloat)radius{
    [self blurWithRadius:radius];
}


- (void)roundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}



@end
