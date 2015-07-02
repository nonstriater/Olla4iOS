//
//  BlockHelper.m
//  FuShuo
//
//  Created by nonstriater on 14-4-23.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "GCDHelper.h"

@implementation GCDHelper
static dispatch_queue_t seria_queue;
static dispatch_queue_t image_queue;
static dispatch_queue_t image_handle_queue(){
    if (image_queue==NULL) {
        image_queue = dispatch_queue_create("com.nonstriater.queue.image.filter",0);
    }
    return image_queue;
}

static dispatch_queue_t serial_task_queue(){
    
    if (seria_queue==NULL) {
        seria_queue = dispatch_queue_create("com.nonstriater.queue.serial", NULL);
    }
    
    return seria_queue;
}

+ (void)handleSerialTask:(void (^)())block completion:(void (^)())complete{
    
    dispatch_async(serial_task_queue(), ^{
        @autoreleasepool {
         
            if (block) {
                block();
            }
            dispatch_async(dispatch_get_main_queue(), ^{
            
                if (complete) {
                    complete();
                }
            });
        }
    });
    
    
}

+ (void)handleImageInBackground:(void (^)())block completion:(void (^)())finish{
    
    dispatch_async(image_handle_queue(),^{
        @autoreleasepool {
            block();
            dispatch_async(dispatch_get_main_queue(),^{
                finish();
            });
        }
    });
}

+ (void)dispatchBlock:(void (^)())block completion:(void (^)())finish{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        @autoreleasepool {
            if (block) {
                 block();
            }
           
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finish) {// finish 为nil 崩溃！！
                    finish();
                }
                
            });
        }
    });
    
}

@end
