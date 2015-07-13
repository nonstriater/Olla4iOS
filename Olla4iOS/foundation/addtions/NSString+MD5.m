//
//  NSString+MD5.m
//  FuShuo
//
//  Created by nonstriater on 14-1-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>
#import "NSString+MD5.h"
#import "NSData+AES.h"
#import "Olla4iOS.h"

@implementation NSString (MD5)

- (NSString *)URLEncode{
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

//影响url query的有 “=” “ ”
- (NSString *)encodeURLStringByAddingEscapteString{

    CFStringRef strRef = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self,NULL ,(CFStringRef)@"=" , kCFStringEncodingUTF8);
    NSString *output = [[NSString alloc] initWithString:(__bridge NSString *)strRef];
    CFRelease(strRef);
    return output;

    
}

- (NSString *)decodeURLStringByAddingEscapteString{

    return nil;
}


- (NSString *)md5Encode{

    const char *cString = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cString, (int)[self length] , result);
    NSMutableString *hash = [[NSMutableString alloc] init];
    for (int i=0; i<16; i++) {
        [hash appendFormat:@"%02X",result[i]];
    }
    return [hash lowercaseString];
}


- (NSString *)SHA1Encode{
    
    const char *cString = [self UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cString, (int)[self length], result);
    NSMutableString *hash = [[NSMutableString alloc] init];
    for (int i=0; i<20; i++) {
        [hash appendFormat:@"%02X",result[i]];
    }
    return [hash lowercaseString];

}


- (NSData *)base64Decode{
    
    if (IS_IOS7) {
        return nil;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
        return [[NSData alloc] initWithBase64Encoding:self];
#pragma clang diagnostic pop
    }

    return nil;
}


- (NSString *)AESEncodeUsingKey:(NSString *)key{
    NSData *encodeData = [[self dataUsingEncoding:NSUTF8StringEncoding] AES256EncodeWithKey:key];
    // 这里如果用UTF8编码data就会得到一个nil的string，换一个编码，如base64来编码 or ascii
    //NSString *encodeString = [[NSString alloc] initWithData:encodeData encoding:NSUTF8StringEncoding];
    return [encodeData base64Encode];
}

- (NSString *)AESDecodeUsingKey:(NSString *)key{
    NSData *decodeData = [self dataUsingEncoding:NSASCIIStringEncoding];
    NSData *orignalData = [decodeData AES256DecodeWithKey:key];
    NSString *decodeString = [[NSString alloc] initWithData:orignalData encoding:NSUTF8StringEncoding];
    return decodeString;
    
}



@end
