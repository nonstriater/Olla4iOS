//
//  NSData+AES.m
//  OllaFramework
//
//  Created by nonstriater on 14-6-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "NSData+AES.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSData (AES)


- (NSString *)base64Encode{
    //return [self base64Encoding];//iOS7以后就废掉了
    return nil;
}

- (NSString *)md5Encode{

    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (unsigned int)[self length], result);
    
    NSMutableString *hash = [[NSMutableString alloc] init];
    for (int i=0; i<16; i++) {
        [hash appendFormat:@"%02X",result[i]];
    }
    return [hash lowercaseString];
    
}



// iOS 上 noPadding（0x000） 方式aes 加密，得到的数据时 0 lengh
// http://stackoverflow.com/questions/10900894/ios-encryption-aes128-cbc-nopadding-why-is-not-working
// 服务器是nopadding 方式，随意这里改成nopadding的方式


- (NSData *)AES256EncodeWithKey:(NSString *)key{

    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    
    //  support no padding ====================================================
    NSUInteger dataLength = [self length];
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    
    NSUInteger newSize = dataLength;
    if(diff > 0)
    {
        newSize +=  diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [self bytes], [self length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x20;
    }
    // ====================================================
    
    
    size_t bufferSize = [self length]+kCCBlockSizeAES128;
    size_t numberBytesOfEncrypted = 0;
    void *buffer = malloc(bufferSize);
    CCCryptorStatus status = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, 0x000, keyPtr, kCCKeySizeAES128, NULL, dataPtr, sizeof(dataPtr), buffer, bufferSize, &numberBytesOfEncrypted);
    if (status==kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numberBytesOfEncrypted];
    }
    free(buffer);
    return nil;
}


// key should be 32 bytes;;; -4301 error(buffer too small error!)
- (NSData *)AES256DecodeWithKey:(NSString *)key{
    
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [self length] + kCCBlockSizeAES128;
    size_t numberOfBytesDecrypted =0;
    void *buffer = malloc(bufferSize);
    
    CCCryptorStatus status = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, 0x000, keyPtr, kCCKeySizeAES128, NULL, [self bytes], [self length], buffer, bufferSize, &numberOfBytesDecrypted);
    
    if (status == kCCSuccess) {
        // decode 去掉 padding数据 -numberOfBytesDecrypted%16
        return [NSData dataWithBytesNoCopy:buffer length:numberOfBytesDecrypted-numberOfBytesDecrypted%16];
    }else{
        NSLog(@"decode status=%d",status);
    }

    free(buffer);
    return nil;
}


@end



