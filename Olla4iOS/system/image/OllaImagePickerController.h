//
//  OllaImagePickerController.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-16.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , OllaImagePickerType){
    OllaImagePickerCamera,
    OllaImagPickerAlbum,
    OllaImagePickerPhotoLibrary
};

@class OllaImagePickerController;
typedef void(^ImagePickerCompleteBlock)(OllaImagePickerController *controller,UIImage *image);

//图片相机封装
@interface OllaImagePickerController : NSObject

@property(nonatomic,assign) OllaImagePickerType imagePickerType;
@property(nonatomic,strong) ImagePickerCompleteBlock completeBlock;
@property(nonatomic,assign) BOOL allowsEditing;

@property(nonatomic,weak) UIViewController *presentedViewController;

- (instancetype) initWithViewController:(UIViewController *)viewController;
- (void)picker;
- (void)pickerImage;// 快捷接口


@end
