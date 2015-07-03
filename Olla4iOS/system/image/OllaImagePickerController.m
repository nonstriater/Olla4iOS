//
//  OllaImagePickerController.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-16.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaImagePickerController.h"
#import "Olla4iOS.h"

@interface OllaImagePickerController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

    UIImagePickerController *imagePickerController;
}

@end

@implementation OllaImagePickerController{}

- (id) init{

    return [self initWithViewController:nil];
}

- (instancetype) initWithViewController:(UIViewController *)viewController{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    
    _presentedViewController = viewController;
    self.imagePickerType = OllaImagePickerCamera;
    
    return self;
}

- (void)dealloc{
    DDLogInfo(@"~~~dealloc..%@",self);
}


-(void)setImagePickerType:(OllaImagePickerType)imagePickerType{
    
    switch (imagePickerType) {
        case OllaImagePickerCamera:
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {//
                NSLog(@"no camere device available,change to album");
                _imagePickerType = OllaImagPickerAlbum;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                break;
            }
            _imagePickerType = OllaImagePickerCamera;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case OllaImagPickerAlbum:
            _imagePickerType = OllaImagPickerAlbum;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
        case OllaImagePickerPhotoLibrary:
            _imagePickerType = OllaImagePickerPhotoLibrary;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:
            break;
    }
}

-(void)setAllowsEditing:(BOOL)allowsEditing{
    _allowsEditing = allowsEditing;
    imagePickerController.allowsEditing = allowsEditing;
}

- (void)picker{
    
    [_presentedViewController presentViewController:imagePickerController animated:YES completion:^{}];
    
}

- (void)pickerImage{
    
    [UIActionSheet showInView:_presentedViewController.view withTitle:nil cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@[@"Take Photo",@"Choose Photo"] tapBlock:^(UIActionSheet *actionSheet,NSInteger tapIndex){
        if (0==tapIndex) {//camera
            //默认 camera
            [self setImagePickerType:OllaImagePickerCamera];
            [_presentedViewController presentViewController:imagePickerController animated:YES completion:nil];
            
        }else if(1==tapIndex){// album
            
            [self setImagePickerType:OllaImagePickerPhotoLibrary];
            [_presentedViewController presentViewController:imagePickerController animated:YES completion:nil];
            
        }// cancel 2
        
    }];
    
    
}



/*
 // info dictionary keys
 UIKIT_EXTERN NSString *const UIImagePickerControllerMediaType;      // an NSString (UTI, i.e. kUTTypeImage)
 UIKIT_EXTERN NSString *const UIImagePickerControllerOriginalImage;  // a UIImage
 */

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@",[info objectForKey:UIImagePickerControllerMediaType] );
    if (![[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        NSLog(@"选择的不是一张照片");
        return;
    }
    
    if (_completeBlock) {
        UIImage *image = [info objectForKey:picker.allowsEditing?UIImagePickerControllerEditedImage:UIImagePickerControllerOriginalImage];
        [imagePickerController dismissViewControllerAnimated:YES completion:^(){
            _completeBlock(self,image);
        }];
        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{

    [[UIApplication  sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


@end


