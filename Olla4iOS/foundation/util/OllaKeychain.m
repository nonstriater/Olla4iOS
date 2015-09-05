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
        *error = [[NSError alloc] initWithDomain:@"com.olla,keychain.error" code:status userInfo:@{@"message":[OllaKeychain keychainMessageFromStatus:status]}];
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
    
    //如果keychain没有这一项，删除将失败，导致setPassword 返回有值的error，导致bug
    //[OllaKeychain deletePasswordForService:service account:account error:error];
    [OllaKeychain deletePasswordForService:service account:account error:nil];
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
        *error = [[NSError alloc] initWithDomain:@"com.olla.keychain.error" code:status userInfo:@{@"message":[OllaKeychain keychainMessageFromStatus:status]}];
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
        *error = [[NSError alloc] initWithDomain:@"com.olla.keychain.error" code:status userInfo:@{@"message":[OllaKeychain keychainMessageFromStatus:status]}];
        return NO;
    }
    
    return YES;
}

+ (NSString *)keychainMessageFromStatus:(OSStatus)status{
    NSString *message = nil;
    if (status == errSecSuccess) {
        message = @"No error";
    }else if(status == errSecUnimplemented){
        message = @"Function or operation not implemented.";
    }else if(status == errSecParam){
        message = @"One or more parameters passed to the function were not valid";
    }else if(status == errSecAllocate){
        message = @"Failed to allocate memory.";
    }else if(status == errSecNotAvailable){
        message = @"No trust results are available.";
    }else if(status == errSecAuthFailed){
        message = @"Authorization/Authentication failed.";
    }else if(status == errSecDuplicateItem){
        message = @"The item already exists.";
    }else if(status == errSecItemNotFound){
        message = @"The item cannot be found.";
    }else if(status == errSecInteractionNotAllowed){
        message = @"Interaction with the Security Server is not allowed.";
    }else if(status == errSecDecode){
        message = @"Unable to decode the provided data.";
    }else{
        message = @"unknown status code";
    }
    
    return message;
}

@end
