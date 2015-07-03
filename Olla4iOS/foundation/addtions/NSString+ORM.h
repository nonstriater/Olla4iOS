//
//  NSString+ORM.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-28.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ORM)

- (id)modelFromJSONWithClassName:(Class)clazz;

@end
