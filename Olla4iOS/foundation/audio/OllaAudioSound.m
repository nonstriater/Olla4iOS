//
//  OllaAudioSound.m
//  OllaFramework
//
//  Created by nonstriater on 14-8-6.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaAudioSound.h"
#import <AVFoundation/AVFoundation.h>

@implementation OllaAudioSound

+ (void)playAudioSound:(NSString *)audioName{
    
    [OllaAudioSound playAudioSound:audioName bundle:[NSBundle mainBundle]];
}


+ (void)playAudioSound:(NSString *)audioName bundle:(NSBundle *)bundle{
    
    SystemSoundID systemSoundID = 0;
    NSString *path = [bundle pathForResource:audioName ofType:@"wav"];
    NSURL *url = [NSURL URLWithString:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &systemSoundID);
    AudioServicesPlaySystemSound(systemSoundID);
    AudioServicesRemoveSystemSoundCompletion(systemSoundID);
    //AudioServicesDisposeSystemSoundID(systemSoundID);// 直接dispose将不会播出声音

}


+ (void)vibrate{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
