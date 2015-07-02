//
//  NSObject+check.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-17.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "Olla4iOS.h"

@implementation NSObject (check)

- (BOOL)isArray{
    return [self isKindOfClass:[NSArray class]];
}
- (BOOL)isDictionary{
    return [self isKindOfClass:[NSDictionary class]];
}
- (BOOL)isString{
    return [self isKindOfClass:[NSString class]];
}
- (BOOL)isNumber{
    return [self isKindOfClass:[NSNumber class]];
}

- (BOOL)isNull{
    return [self isKindOfClass:[NSNull class]];
}

- (BOOL)isImage{
    return [self isKindOfClass:[UIImage class]];
}

- (BOOL)isData{
    return [self isKindOfClass:[NSData class]];
}


- (BOOL)booleanValueForKey:(NSString *)key default:(BOOL)defaultValue{
    id value = [self valueForKey:key];
    if ([value respondsToSelector:@selector(boolValue)]) {
        return [value boolValue];
    }
    return defaultValue;
}

-(BOOL) booleanValueForKey:(NSString *) key{
    return [self booleanValueForKey:key default:NO];
}


- (NSDictionary *)dictionaryRepresentation{
    
    if ([self isDictionary]) {
        return (NSDictionary *)self;
    }
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    
    unsigned count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i=0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
       
        id value = nil;
        @try {
           value = [self valueForKey:propertyName];
        }
        @catch (NSException *exception) {
            value = [NSNull null];
        }
        
        if (!value) {
            value = [NSNull null];
        }else{
            value = [self getValueInternal:value];
        }
        [dict setValue:value forKey:propertyName];
    }
    free(properties);
    return dict;
}


- (id)getValueInternal:(id)object{

    if ([object isString] || [object isNumber] || [object isNull]) {
        return object;
    }else if([object isImage]){//图片类型
        return [NSNull null];
    }else if([object isData]){//二进制数据类型
        return [NSNull null];
    }else if([object isArray]){
        NSArray *arrayObjects = (NSArray *)object;
        NSMutableArray *handledObjects = [NSMutableArray arrayWithCapacity:[arrayObjects count]];
        for(int i=0;i<[arrayObjects count];i++){
            [handledObjects setObject:[self getValueInternal:arrayObjects[i]] atIndexedSubscript:i];
        }
        return handledObjects;
    }else if([object isDictionary]){
        NSDictionary *dict = (NSDictionary *)object;
        NSMutableDictionary *handledDict = [NSMutableDictionary dictionary];
        for (NSString *key in dict.allKeys) {
            [handledDict setObject:[self getValueInternal:dict[key]] forKey:key];
        }
        return handledDict;
    }
 
    //对象类型
    return [object dictionaryRepresentation];
}


- (NSString *)JSONString{
    
    if ([self isNull]) {
        return nil;
    }
    
    if ([self isString] ||[self isNumber] ) {
        return [NSString stringWithFormat:@"%@",self];
    }
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:[self dictionaryRepresentation] options:0 error:&error];
    if (error) {
        NSLog(@"JSON Write ERROR:%@",error);
    }

    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}




@end
