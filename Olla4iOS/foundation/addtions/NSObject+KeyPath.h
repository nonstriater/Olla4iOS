//
//  NSObject+KeyPath.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KeyPath)

- (id)dataForKeyPath:(NSString *)keyPath;

@end
