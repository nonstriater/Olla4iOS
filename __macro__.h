//
//  __macro__.h
//
//  Created by null on 14-10-15.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#ifndef Olla___macro___h
#define Olla___macro___h


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_IOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define IS_IOS8 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define IS_3_5 ([[UIScreen mainScreen] bounds].size.height==480)

#define IS_IPHONE ([[ [ UIDevice currentDevice ] model ] rangeOfString:@"iPhone"].location != NSNotFound)
#define IS_IPAD ([[ [ UIDevice currentDevice ] model ] rangeOfString:@"iPad"].location != NSNotFound)
#define IS_IPHONE_5 ( IS_IPHONE && IS_WIDESCREEN )



#define Screen_Height [[UIScreen mainScreen] bounds].size.height
#define Screen_Width [[UIScreen mainScreen] bounds].size.width
#define View_Height IS_IOS7?(Screen_Height):(Screen_Height-20)


#endif



