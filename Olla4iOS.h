//
//  OllaFramework.h
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

///////////////// basic /////////////////////////////

#import "foundation.h"

#import <objc/runtime.h>
#import "__macro__.h"


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AVFoundation/AVFoundation.h"


////////////////////// log /////////////////////////////
#undef __ON__
#define __ON__ (1)

#define __OLLA_LOG__ (__ON__)

#if defined(__OLLA_LOG__) && __OLLA_LOG__

#define NLog(fmt,...) NSLog((@"%@ [line %d]" fmt),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__)
#define ULog(fmt,...) {UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show];}

#else

#define NLog(...) {}
#define ULog(fmt,...)

#endif


///////////////// version /////////////////////////////

#undef OLLA_VERSION
#define OLLA_VERSION @"0.1.1"




