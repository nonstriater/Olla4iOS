//
//  NSDictionary+additions.m
//  FuShuo
//
//  Created by nonstriater on 14-1-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "Olla4iOS.h"
#import "foundation.h"

@implementation NSDictionary (additions)

- (BOOL)check{
    return [self isKindOfClass:[NSDictionary class]];
}

- (NSDictionary *)replaceNilValue{

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString *key in self.allKeys) {
        id value = [self valueForKey:key];
        if (!value) {
            value = @"";
        }
        [dict setValue:value forKey:key];
    }
    return [dict copy];
}

- (NSMutableDictionary *)propertyListDictionary{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (NSString *key in [self allKeys]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSNull class]]) {
            value = @"";
        }
        if ([value isDictionary]) {
            value = [value propertyListDictionary];
        }
        [dictionary setValue:value forKey:key];
        
    }
    return dictionary;
}

//目前array类型只支持字符串，不支持clazz中的array时nsobject类型
- (id)modelFromDictionaryWithClassName:(Class)clazz{
    
    id model = [[clazz alloc] init];
    
    unsigned int count=0;
    objc_property_t *propertys = class_copyPropertyList(clazz, &count);
    for (int i=0; i<count; i++) {
        objc_property_t property = propertys[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding] ;
        id value = [self valueForKey:propertyName];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            // 运行时检查property类型
            const char *typeName= property_getAttributes(property);
            NSString *className = [self className:[NSString stringWithCString:typeName encoding:NSUTF8StringEncoding]];
            id subModel = [(NSDictionary *)value modelFromDictionaryWithClassName:NSClassFromString(className)];
            value = subModel;
            
            
        }else if([value isKindOfClass:[NSArray class]]){
            
            //NSLog(@"****** error ***** value NSArrary not supprot nsobject type");
            //@property (nonatomic, strong) NSArray<MyClass>* subList;
            //T@"NSArray",C,N,V_mySelf
            //  数组里面类型各异，可以是NSString，nsobject，或者混合
            
        }
        
        if ([value isKindOfClass:[NSNull class]]) {
            value = nil;
        }
        
        @try {
            [model setValue:value forKey:propertyName];
        }
        @catch (NSException *exception) {
            NSLog(@"setValue:(%@)forKey:(%@) Exception:%@",value,propertyName,exception);
        }
        @finally {
            
        }
        
    }
    free(propertys);
    
    return model;
}

//T@"NSString",C,N,V_test ==> 属性名
- (NSString*) className:(NSString *)propertyTypeName {
    NSString* name = [[propertyTypeName componentsSeparatedByString:@","] objectAtIndex:0];
    NSString* cName = [[name substringToIndex:[name length]-1] substringFromIndex:3];
    return cName;
}



/**
 
 普通的：
 @{
 @"a":1,
 @"b":2
 }
 
 model map:
 @{
 @"a":@"A",
 @"b":@"B"
 }
 
 ====>
 retult:
 @{
 @"A":1,
 @"B":2
 }
 
 带嵌套时：
 
 @{
 @"a":1,
 @"b":@{@"c":2}
 }
 
 model map:
 @{
 @"a":@"A",
 @"b":@{@"c":@"C"}
 }
 
 ====>
 retult:
 @{
 @"A":1,
 @"b":@{@"C":2}
 }
 
 */
- (NSDictionary *)conversionWithModelMap:(NSDictionary *)map{
    
    if (!map) {
        return self;
    }
    
    NSMutableDictionary *results = [NSMutableDictionary dictionary];
    for (NSString *key in self.allKeys) {
        
        NSString *_key = key;
        
        id value = [map valueForKey:key];
        
        if ([value isNull]) {
            NSLog(@"nil value detect for key:%@",_key);
            value = _key;
        }
        
        if ([value isDictionary]) {//嵌套
            
            value = [[self valueForKey:key] conversionWithModelMap:value];
        }
        
//        if (![value isString]) {
//            DDLogWarn(@"********* object map error ****** (%@->%@),程序自动转为(%@)",key,value,key);
//            value = _key;
//        }
//        
        if (value) {
            _key = value;
        }
        
        [results setValue:[self valueForKey:key] forKey:_key];
    }
    
    return results;
    
    // NSNumber, NSNull , NSString, NSDictionary,NSArray
}



@end
