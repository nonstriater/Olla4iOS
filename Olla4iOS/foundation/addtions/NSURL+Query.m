//
//  NSURL+Query.m
//  OllaFramework
//
//  Created by nonstriater on 14-6-22.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "NSURL+Query.h"
#import "NSString+MD5.h"
#import "NSObject+check.h"

@implementation NSURL (Query)

@dynamic queryValue;

- (NSDictionary *)queryValue{
    return [self queryValues];
}

- (NSString  *)urlPath{
    if (0==[self.query length]) {
        return [self.absoluteString stringByReplacingOccurrencesOfString:@"?" withString:@""];
    }
    return [[[self absoluteString] stringByReplacingOccurrencesOfString:self.query withString:@""] stringByReplacingOccurrencesOfString:@"?" withString:@""];

}

- (NSDictionary *)queryValues{

    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    NSArray *components = [[self query] componentsSeparatedByString:@"&"];
    for (NSString *item in components) {
        NSArray * kv= [item componentsSeparatedByString:@"="];
        if ([kv count]==1) {//值为空的情况
            [dictionary setValue:@"" forKey:[kv objectAtIndex:0]];
        }
        if ([kv count]>1) {
            // 对value 反 url编码
            NSString *decodeValue = [[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [dictionary setValue:decodeValue forKey:[kv objectAtIndex:0]];
        }
    }
    return dictionary;
}

- (NSURL *)URLByAppendingPathComponent:(NSString *)string queryValue:(NSDictionary *)queryValue{
    // 如果string已经在url中了，就直接back回去
    
    NSString *url = nil;
    
    NSRange range = [[self absoluteString] rangeOfString:string];
    if(range.location != NSNotFound){// 已经在
        url = [[self absoluteString] substringToIndex:range.location+range.length];
    }else{// 不再
        url = [[self URLByAppendingPathComponent:string] absoluteString];
    }
    
    return [NSURL URLWithString:url queryValue:queryValue];

}


+ (NSURL *)URLWithString:(NSString *)string queryValue:(NSDictionary *)queryValue{

    return [NSURL URLWithString:string relativeToURL:nil queryValues:queryValue];
}


+ (NSURL *)URLWithString:(NSString *)string relativeToURL:(NSURL *)baseURL queryValues:(NSDictionary *)query{
    NSMutableString *ms = [NSMutableString string];
    BOOL isFirst=NO;
    NSRange range = [string rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        isFirst = YES;
        [ms appendString:@"?"];
    }
    
    if ([query isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in query) {
            
            id value = [query valueForKey:key];
            if([value isKindOfClass:[NSNumber class]]){
                value = [value stringValue];
            }
            if ([value isKindOfClass:[NSString class]]) {
                if (!isFirst) {
                    [ms appendString:@"&"];
                }
                value = [NSString stringWithFormat:@"%@",value] ;
                value = [value encodeURLStringByAddingEscapteString];// 对value坐下url编码，以免里面有“=”，“ ”之类的字符造成异常
                [ms appendFormat:@"%@=%@",key,value];
                isFirst = NO;
            }
            
            if ([value isDictionary]) {
                
            }
            // 如果value是NSNULL类型，将不能成功常见NSURL xxxxx
            
        }
    }
    
    return [NSURL URLWithString:[string stringByAppendingString:ms] relativeToURL:baseURL];
    // baseURL 为nil会导致 返回nil！！！！?????测试不是这样的
    
    /**
   使用stringByAddingPercentEscaptesUsingEncoding，有些字符任然不会编码 如 =，&，？
     可以使用CFURLCreateStringByAddingPercentEscapes() 来编码
     
     汉字编码问题：
     
     
     */
    
}


- (NSString *)firstPathComponent{

    NSArray *components = [self pathComponents];
    if ([components count]>0) {
        return [components objectAtIndex:0];
    }
    
    return nil;
    
}

- (NSString *)firstPathComponentRelativeTo:(NSString *)basePath;{

    if (![basePath hasSuffix:@"/"]) {
        basePath = [basePath stringByAppendingString:@"/"];
    }
    
    if ([basePath length] < [[self path] length]) {
        NSString *path =[[self path] substringFromIndex:[basePath length]];
        if ([[path pathComponents] count]>0) {
            return [path pathComponents][0];
        }
    }
    
    return nil;
}



@end
