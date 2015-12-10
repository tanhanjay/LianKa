//
//  MyFaceDection.m
//  LianKa
//
//  Created by tenghaojun on 15/12/8.
//  Copyright © 2015年 tenghaojun. All rights reserved.
//

#import "MyFaceDection.h"





@implementation MyFaceDection

-(id)init{
    self = [super init];
    if (self!=nil) {
        NSString *API_KEY = _API_KEY;
        NSString *API_SECRET = _API_SECRET;
        [FaceppAPI initWithApiKey:API_KEY andApiSecret:API_SECRET andRegion:APIServerRegionCN];
        [FaceppAPI setDebugMode:NO];

    }
    return self;
   }

- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


- (Face83Position *)landmark83PfaceImage:(UIImage *)image{
    Face83Position * postionModel;
    image = [self fixOrientation:image];
    FaceppResult *result = [self faceDetectionWithImage:image];
    if (result.success) {
        if ([[result content][@"face"] count]!=0) {
            // draw rectangle in the image
            int face_count = (int)[[result content][@"face"] count];
            for (int i=0; i<face_count; i++) {
                

                NSString *faceId;
                faceId = [result content][@"face"][0][@"face_id"];
                FaceppResult *landMark83PResult = [[FaceppAPI detection]landmarkWithFaceId:faceId andType:FaceppLandmark83P];
                postionModel = [Face83Position getInstanceWithFaceppResult:landMark83PResult];
               
            }
        }
    }
    return postionModel;
  }

- (FaceppResult *)faceDetectionWithImage:(UIImage *)image{
    image = [self fixOrientation:image];
    FaceppResult *result = [[FaceppAPI detection]detectWithURL:nil orImageData:UIImageJPEGRepresentation(image, 0.5) mode:FaceppDetectionModeOneFace attribute:FaceppDetectionAttributeAll];
    
    return result;
}

@end
