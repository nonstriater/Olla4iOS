//
//  UIDevice+Hardware.m
//  FuShuo
//
//  Created by nonstriater on 14-1-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "UIDevice+Hardware.h"

@implementation UIDevice (Hardware)

+ (NSArray *)screenSizes{

    return @[@"320x480", // iphone 3g,3gs,touch 1,2,3
             @"640x960", // iphone 4, 4s, touch 4
             @"640x1136",// iphone 5,5s,5c,  touch 5
             @"750x1336",// iphone 6 （375x667 @2x）
             @"1242x2208",// iphone 6+ （414x736 @3x）
             @"768x1024",// ipad 1,2, mini
             @"1536x2048"// new ipad,ipad 4
             ];
}

@end
