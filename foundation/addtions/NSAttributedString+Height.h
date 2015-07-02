//
//  NSAttributedString+Height.h
//  FuShuo
//
//  Created by nonstriater on 14-5-3.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface NSAttributedString (Height)

- (CGFloat)boundingHeightForWidth:(CGFloat)inWidth;
- (CGFloat)boundingHeightWithFrameSetter:(CTFramesetterRef)frameSetter ForWidth:(CGFloat)inWidth;

@end
