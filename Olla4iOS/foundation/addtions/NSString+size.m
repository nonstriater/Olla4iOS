//
//  NSString+size.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-16.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "NSString+size.h"
#import "Olla4iOS.h"

@implementation NSString (size)

//TODO: 这里先用integerValue
//- (NSUInteger)unsignedLongLongValue{
//    return [self integerValue];
//}

- (BOOL)containsSubString:(NSString *)string{
    if (IS_IOS8) {
         return [self containsString:string];
    }
    
    return ([self rangeOfString:string].length != 0);
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedSize:(CGSize)size{
    
    CGSize retSize = CGSizeZero;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")) {
        
        CGRect rect =  [self boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        retSize.width = ceil(rect.size.width);
        retSize.height = ceil(rect.size.height);
        
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
        retSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
    }
    
    return retSize;
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedSize:(CGSize)size numberOfLine:(NSUInteger)lines{
    CGFloat height = lines?font.lineHeight*lines:size.height;
    CGSize constrainedSize = CGSizeMake(size.width, height);
    return[self sizeWithFont:font constrainedSize:constrainedSize];
}

- (NSString *)escapeSpace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)firstLetter{
    
    if ([self length]) {
        return [self substringToIndex:1];
    }
    
    return nil;
}


- (NSString *)addEscapeSQLCharacters{
    
    NSRange range;
    NSMutableString *string = [NSMutableString string];
    for (int i=0; i<self.length; i+=range.length) {
        range = [self rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *s = [self substringWithRange:range];
        if ([s isEqualToString:@"'"]) {
            [string appendString:@"''"];// sqlite插入单引号的方法是双单引号
        }else{
            [string appendString:s];
        }
    }
    
    return string;
}

- (NSString *)removeEscapeSQLCharacters{
    return nil;
}

- (BOOL)isHTTPURL{

    if ([self hasPrefix:@"http://"] || [self hasPrefix:@"https://"]) {
        return YES;
    }
    
    return NO;
}

@end
