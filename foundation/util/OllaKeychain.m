//
//  OllaKeychain.m
//  OllaFramework
//
//  Created by nonstriater on 14-6-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaKeychain.h"

@implementation OllaKeychain

+ (NSString *)passwordForService:(NSString *)service account:(NSString *)account error:(NSError **)error{
    
    if (!service || ! account) {
        if (error) {
            *error = [[NSError alloc] initWithDomain:@"com.olla.keychain.error" code:-0001 userInfo:@{@"message":@"Some of the arguments were invalid"}];
        }
        return nil;
    }
    
    
    CFTypeRef result = NULL;
    OSStatus status =  0;
    NSDictionary *query = @{(__bridge id)kSecClass:(__bridge id )kSecClassGenericPassword,
                            (__bridge id)kSecAttrService:service,
                            (__bridge id)kSecAttrAccount:account,
                            (__bridge id)kSecMatchLimit:(__bridge id)kSecMatchLimitOne,
                            (__bridge id)kSecReturnData:@YES};
    status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
    if (status != errSecSuccess && error != NULL) {
        *error = [[NSError alloc] initWithDomain:@"com.olla,keychain.error" code:-0002 userInfo:@{@"message":@"Some thing wrong"}];
        return nil;
    }
    
    
    return [[NSString alloc] initWithData:[NSData dataWithData:(__bridge_transfer NSData *)result]  encoding:NSUTF8StringEncoding ];
    
}

+ (BOOL)setPassword:(NSString *)password forService:(NSString *)service account:(NSString *)account error:(NSError **)error{
    
    if (!service || !account) {
        if (error) {
            *error = [[NSError alloc] initWithDomain:@"com.olla.keychain.error" code:-0001 userInfo:@{@"message":@"Some of the arguments were invalid"}];
        }
        return NO;
    }
    
    [OllaKeychain deletePasswordForService:service account:account error:error];
    if (!password) {
        return YES;
    }
    NSDictionary *query = @{(__bridge id)kSecClass:(__bridge id )kSecClassGenericPassword,
                            (__bridge id)kSecAttrService:service,
                            (__bridge id)kSecAttrAccount:account,
                            (__bridge id)kSecValueData:[password dataUsingEncoding:NSUTF8StringEncoding]};
    OSStatus status = 0;
    status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    
    if (status != errSecSuccess && error!=NULL) {
        *error = [[NSError alloc] initWithDomain:@"com.olla.keychain.error" code:-0002 userInfo:@{@"message":@"Some thing wrong"}];
        return NO;
    }
    
    return YES;
}

+ (BOOL)deletePasswordForService:(NSString *)service account:(NSString *)account error:(NSError **)error{

    if (!service || !account) {
        if (error) {
            *error = [[NSError alloc] initWithDomain:@"com.olla.keychain.error" code:-0001 userInfo:@{@"message":@"Some of the arguments were invalid"}];
        }
        return NO;
    }
    
    NSDictionary *query = @{(__bridge id)kSecClass:(__bridge id )kSecClassGenericPassword,
                            (__bridge id)kSecAttrService:service,
                            (__bridge id)kSecAttrAccount:account};
    OSStatus status=0;
    status = SecItemDelete((__bridge CFDictionaryRef)query);
    
    if (status!=errSecSuccess && error!=NULL) {
        *error = [[NSError alloc] initWithDomain:@"com.olla.keychain.error" code:-0002 userInfo:@{@"message":@"Some thing wrong"}];
        return NO;
    }
    
    return YES;
}


@end
