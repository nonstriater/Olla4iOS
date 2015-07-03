//
//  UIImage+Filter.m
//  FuShuo
//
//  Created by nonstriater on 14-1-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "UIImage+Filter.h"


//LOMO
const float colormatrix_lomo[] = {
    1.7f,  0.1f, 0.1f, 0, -73.1f,
    0,  1.7f, 0.1f, 0, -73.1f,
    0,  0.1f, 1.6f, 0, -73.1f,
    0,  0, 0, 1.0f, 0 };

//黑白
const float colormatrix_heibai[] = {
    0.8f,  1.6f, 0.2f, 0, -163.9f,
    0.8f,  1.6f, 0.2f, 0, -163.9f,
    0.8f,  1.6f, 0.2f, 0, -163.9f,
    0,  0, 0, 1.0f, 0 };
//复古
const float colormatrix_vintage[] = {
    0.2f,0.5f, 0.1f, 0, 40.8f,
    0.2f, 0.5f, 0.1f, 0, 40.8f,
    0.2f,0.5f, 0.1f, 0, 40.8f,
    0, 0, 0, 1, 0 };

//哥特
const float colormatrix_gete[] = {
    1.9f,-0.3f, -0.2f, 0,-87.0f,
    -0.2f, 1.7f, -0.1f, 0, -87.0f,
    -0.1f,-0.6f, 2.0f, 0, -87.0f,
    0, 0, 0, 1.0f, 0 };

//锐化
const float colormatrix_sharp[] = {
    4.8f,-1.0f, -0.1f, 0,-388.4f,
    -0.5f,4.4f, -0.1f, 0,-388.4f,
    -0.5f,-1.0f, 5.2f, 0,-388.4f,
    0, 0, 0, 1.0f, 0 };


//淡雅
const float colormatrix_danya[] = {
    0.6f,0.3f, 0.1f, 0,73.3f,
    0.2f,0.7f, 0.1f, 0,73.3f,
    0.2f,0.3f, 0.4f, 0,73.3f,
    0, 0, 0, 1.0f, 0 };

//酒红
const float colormatrix_jiuhong[] = {
    1.2f,0.0f, 0.0f, 0.0f,0.0f,
    0.0f,0.9f, 0.0f, 0.0f,0.0f,
    0.0f,0.0f, 0.8f, 0.0f,0.0f,
    0, 0, 0, 1.0f, 0 };

//清宁
const float colormatrix_qingning[] = {
    0.9f, 0, 0, 0, 0,
    0, 1.1f,0, 0, 0,
    0, 0, 0.9f, 0, 0,
    0, 0, 0, 1.0f, 0 };

//浪漫
const float colormatrix_langman[] = {
    0.9f, 0, 0, 0, 63.0f,
    0, 0.9f,0, 0, 63.0f,
    0, 0, 0.9f, 0, 63.0f,
    0, 0, 0, 1.0f, 0 };

//光晕
const float colormatrix_guangyun[] = {
    0.9f, 0, 0,  0, 64.9f,
    0, 0.9f,0,  0, 64.9f,
    0, 0, 0.9f,  0, 64.9f,
    0, 0, 0, 1.0f, 0 };

//蓝调
const float colormatrix_landiao[] = {
    2.1f, -1.4f, 0.6f, 0.0f, -31.0f,
    -0.3f, 2.0f, -0.3f, 0.0f, -31.0f,
    -1.1f, -0.2f, 2.6f, 0.0f, -31.0f,
    0.0f, 0.0f, 0.0f, 1.0f, 0.0f
};

//梦幻
const float colormatrix_menghuan[] = {
    0.8f, 0.3f, 0.1f, 0.0f, 46.5f,
    0.1f, 0.9f, 0.0f, 0.0f, 46.5f,
    0.1f, 0.3f, 0.7f, 0.0f, 46.5f,
    0.0f, 0.0f, 0.0f, 1.0f, 0.0f
};

//夜色
const float colormatrix_yese[] = {
    1.0f, 0.0f, 0.0f, 0.0f, -66.6f,
    0.0f, 1.1f, 0.0f, 0.0f, -66.6f,
    0.0f, 0.0f, 1.0f, 0.0f, -66.6f,
    0.0f, 0.0f, 0.0f, 1.0f, 0.0f
};


static void adjustColorValue(int *color){
    
    if (*color<0) {
        *color=0;
    }
    
    if (*color>255) {
        *color=255;
    }
    
}

static UIImage *filterOutputImage(UIImage *image,const float *f){
    
    // create bitmap context
    float width = CGImageGetWidth(image.CGImage);
    float height = CGImageGetHeight(image.CGImage);
    int bitsPerComponent = 8;// 每个通道占8bits，一个字节
    long bytesPerRow = width*4;
    size_t bitmapBytesCount = bytesPerRow * height;
    //void *bitmapData = malloc(bitmapBytesCount);
    CGColorSpaceRef inputColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, bitsPerComponent, bytesPerRow,inputColorSpace , kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);//rgba
    CGColorSpaceRelease(inputColorSpace);
    if (!bitmapContext) {
        CGContextRelease(bitmapContext);
        return nil;
    }
    
    // get image datas
    CGRect rect = {{0,0},{width,height}};
    CGContextDrawImage(bitmapContext, rect, image.CGImage);
    UInt8 *datas = (UInt8 *)CGBitmapContextGetData(bitmapContext);
    
    
    //handle every pixel datas
    for (int i=0; i<bitmapBytesCount;i+=4){
        
        int r = f[0] * datas[i] + f[1] * datas[i+1] + f[2] * datas[i+2] + f[3] * datas[i+3] + f[4];
        int g = f[0+5] * datas[i] + f[1+5] * datas[i+1] + f[2+5] * datas[i+2] + f[3+5] * datas[i+3] + f[4+5];
        int b = f[0+5*2] * datas[i] + f[1+5*2] * datas[i+1] + f[2+5*2] * datas[i+2] + f[3+5*2] * datas[i+3] + f[4+5*2];
        int a = f[0+5*3] * datas[i] + f[1+5*3] * datas[i+1] + f[2+5*3] * datas[i+2] + f[3+5*3] * datas[i+3] + f[4+5*3];
        
        adjustColorValue(&r);
        adjustColorValue(&b);
        adjustColorValue(&g);
        adjustColorValue(&a);
        
        datas[i]=r;
        datas[i+1]=g;
        datas[i+2]=b;
        datas[i+3]=a;
        
    }
    
   // 创建输出  -->造成了崩溃！！！ fixed
//    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL,datas, bitmapBytesCount, NULL);
//    CGColorSpaceRef outputColorSpace = CGColorSpaceCreateDeviceRGB();
//    CGImageRef ouputImageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerComponent*4, bytesPerRow, outputColorSpace, kCGBitmapByteOrderDefault, provider, NULL, NO, kCGRenderingIntentDefault);
    CGImageRef ouputImageRef = CGBitmapContextCreateImage(bitmapContext);
    UIImage *retImage = [UIImage imageWithCGImage:ouputImageRef];
    
     // return and release dest soruce
//    CGDataProviderRelease(provider);
//    CGColorSpaceRelease(outputColorSpace);
    CGImageRelease(ouputImageRef);
    CGContextRelease(bitmapContext);
    
    return retImage;
}



@implementation UIImage (Filter)

- (UIImage *)LOMOFilterOutput{

    return filterOutputImage(self, colormatrix_lomo);
    
}  // LOMO

- (UIImage *)grayFilterOutput{
    
    return filterOutputImage(self, colormatrix_heibai);
}  //黑白

- (UIImage *)vintageFilterOutput{

    return filterOutputImage(self, colormatrix_vintage);
} //复古

- (UIImage *)geteFilterOutput{
    return filterOutputImage(self, colormatrix_gete);
}  // 哥特

- (UIImage *)sharpFilterOutput{
    return filterOutputImage(self, colormatrix_sharp);
}  // 锐化

- (UIImage *)elegantFilterOutput{
    return filterOutputImage(self, colormatrix_danya);
} //淡雅

- (UIImage *)redWineFilterOutput{
    return filterOutputImage(self, colormatrix_jiuhong);
} // 酒红

- (UIImage *)quietFilterOutput{
    return filterOutputImage(self, colormatrix_qingning);
}    //清宁

- (UIImage *)romanticFilterOutput{
    return filterOutputImage(self, colormatrix_langman);
} // 浪漫

- (UIImage *)shineFilterOutput{
    return filterOutputImage(self, colormatrix_guangyun);
}  // 光晕

- (UIImage *)blueFilterOutput{
    return filterOutputImage(self, colormatrix_landiao);
}   // 蓝调

- (UIImage *)dreamFilterOutput{
    return filterOutputImage(self, colormatrix_menghuan);
} // 梦幻

- (UIImage *)darkFilterOutput{
    return filterOutputImage(self, colormatrix_yese);
} // 夜色


- (UIImage *)gaussBlurFilterWithLevel:(CGFloat)blurLevel{

    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputImageKey ,inputImage, @"inputRadius",@(blurLevel) ,nil];

    
    CIImage *outputImage = filter.outputImage;
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return img;
}

- (UIImage *)blurWithLevel:(CGFloat)blurLevel{
    
    CIContext *context   = [CIContext contextWithOptions:nil];
    CIImage *sourceImage = [CIImage imageWithCGImage:self.CGImage];
    
    // Apply clamp filter:
    // this is needed because the CIGaussianBlur when applied makes
    // a trasparent border around the image
    
    NSString *clampFilterName = @"CIAffineClamp";
    CIFilter *clamp = [CIFilter filterWithName:clampFilterName];
    if (!clamp) {
        
        NSLog(@"");
        return nil;
    }
    
    [clamp setValue:sourceImage
             forKey:kCIInputImageKey];
    CIImage *clampResult = [clamp valueForKey:kCIOutputImageKey];
    
    // Apply Gaussian Blur filter
    
    NSString *gaussianBlurFilterName = @"CIGaussianBlur";
    CIFilter *gaussianBlur           = [CIFilter filterWithName:gaussianBlurFilterName];
    if (!gaussianBlur) {
        
        NSLog(@"");
        return nil;
    }
    
    [gaussianBlur setValue:clampResult
                    forKey:kCIInputImageKey];
    [gaussianBlur setValue:[NSNumber numberWithFloat:blurLevel]
                    forKey:@"inputRadius"];
    
    CIImage *gaussianBlurResult = [gaussianBlur valueForKey:kCIOutputImageKey];
    
    
    CGImageRef cgImage = [context createCGImage:gaussianBlurResult
                                       fromRect:[sourceImage extent]];
    
    UIImage *blurredImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);

    return blurredImage;
}


@end
