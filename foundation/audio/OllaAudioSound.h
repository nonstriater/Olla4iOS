//
//  OllaAudioSound.h
//  OllaFramework
//
//  Created by nonstriater on 14-8-6.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OllaAudioSound : NSObject

+ (void)playAudioSound:(NSString *)audioName;
+ (void)playAudioSound:(NSString *)audioName bundle:(NSBundle *)bundle;

+ (void)vibrate;

@end
