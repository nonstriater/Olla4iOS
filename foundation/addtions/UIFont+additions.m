//
//  UIFont+additions.m
//  FuShuo
//
//  Created by nonstriater on 14-2-3.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "UIFont+additions.h"
#import <CoreText/CoreText.h>

@implementation UIFont (additions)

+ (UIFont *)boldFont:(UIFont *)font{

    UIFont *result = nil;
    
    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef)(font.fontName),
                                            font.pointSize, NULL);
    if (ctFont) {
        // You can't add bold to a bold font
        // (don't really need this, since the ctBoldFont check would handle it)
        if ((CTFontGetSymbolicTraits(ctFont) & kCTFontTraitBold) == 0) {
            CTFontRef ctBoldFont = CTFontCreateCopyWithSymbolicTraits(ctFont,
                                                                      font.pointSize,
                                                                      NULL,
                                                                      kCTFontBoldTrait,
                                                                      kCTFontBoldTrait);
            if (ctBoldFont) {
                NSString *fontName = CFBridgingRelease(CTFontCopyPostScriptName(ctBoldFont));
                result = [UIFont fontWithName:fontName size:font.pointSize];
                CFRelease(ctBoldFont);
            }
        }
        CFRelease(ctFont);
    }
    return result;


}

@end
