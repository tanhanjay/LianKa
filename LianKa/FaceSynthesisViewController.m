//
//  ViewController.m
//  效果模拟测试
//
//  Created by tenghaojun on 15/11/1.
//  Copyright © 2015年 tenghaojun. All rights reserved.
//

#import "FaceSynthesisViewController.h"
#import "MBProgressHUD.h"
#import "APIKey+APISecret.h"
#import "FaceppAPI.h"


@interface FaceSynthesisViewController ()
@property (strong, nonatomic) FaceImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bodyImageView;
@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (nonatomic,strong) UIImageView *currentImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic,assign) BOOL isfaceviewtop;
@end

@implementation FaceSynthesisViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *API_KEY = _API_KEY;
    NSString *API_SECRET = _API_SECRET;
    [FaceppAPI initWithApiKey:API_KEY andApiSecret:API_SECRET andRegion:APIServerRegionCN];
    [FaceppAPI setDebugMode:YES];
   
}

// 懒加载

- (FaceImageView *)faceImageView{
    if (_faceImageView == nil) {
        _faceImageView = [[FaceImageView alloc]init];
        _faceImageView.frame=CGRectMake(150, 150, 100, 100);
        [self.view addSubview:_faceImageView];
        _faceImageView.delegate =self;
        _faceImageView.userInteractionEnabled = YES;
    }
    return _faceImageView;
}

- (UIImagePickerController *)imagePicker
{
    if (!_imagePicker ) {
        _imagePicker = [[UIImagePickerController alloc]init];
    }
    return _imagePicker;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)facePhotoByLibrary:(id)sender {
    self.currentImageView = self.faceImageView;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:^{
            
        }];
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"failed to camera";
        [hud show:YES];
        [hud performSelector:@selector(hide:) withObject:@YES afterDelay:2];
        
    }

}

- (IBAction)changPhoto:(id)sender {
    self.currentImageView = self.bodyImageView;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
       
        [self presentViewController:self.imagePicker animated:YES completion:^{
            
        }];
    }
    else {
        MBProgressHUD *hud = [[MBProgressHUD alloc]init];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"failed to access photo library";
        [hud show:YES];
        
    }

}

- (IBAction)takePhoto:(id)sender {
    self.currentImageView = self.faceImageView;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        [self presentViewController:self.imagePicker animated:YES completion:^{
            
        }];
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"failed to camera";
        [hud show:YES];
        [hud performSelector:@selector(hide:) withObject:@YES afterDelay:2];
        
    }

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


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    UIImage *image = info[UIImagePickerControllerOriginalImage];
 
    [self dismissViewControllerAnimated:YES completion:^{
        
        if (self.currentImageView == self.faceImageView) {

            UIImage *fixedImage = [self fixOrientation:image];

            [self performSelectorInBackground:@selector(detectefaceImageWithImage:) withObject:fixedImage];


           
        }else{
            self.currentImageView.image = image;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
    }];
  
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

    


- (void)detectefaceImageWithImage:(UIImage *)image{
    UIImage *faceimage = [[UIImage alloc]init];
    FaceppResult *result = [[FaceppAPI detection] detectWithURL:nil orImageData:UIImageJPEGRepresentation(image, 0.5) mode:FaceppDetectionModeNormal attribute:FaceppDetectionAttributeAll];
    if (result.success) {
        double image_width = [[result content][@"img_width"] doubleValue] *0.01f;
        double image_height = [[result content][@"img_height"] doubleValue] * 0.01f;
        if ([[result content][@"face"] count]!=0) {
            // draw rectangle in the image
            int face_count = (int)[[result content][@"face"] count];
            for (int i=0; i<face_count; i++) {
                double width = [[result content][@"face"][i][@"position"][@"width"] doubleValue];
                double height = [[result content][@"face"][i][@"position"][@"height"] doubleValue];
                CGRect rect = CGRectMake(([[result content][@"face"][i][@"position"][@"center"][@"x"] doubleValue] - width/2) * image_width,
                                         ([[result content][@"face"][i][@"position"][@"center"][@"y"] doubleValue] - height/2) * image_height,
                                         width * image_width,
                                         height * image_height);
                //抠脸
                
                faceimage = [self clipImageWithRect:rect andImage:image];
            }
        }
        
        else {
            // some errors occurred
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:[NSString stringWithFormat:@"未侦测到任何面部\nerror message: %@", [result error].message]
                                  message:@""
                                  delegate:nil
                                  cancelButtonTitle:@"OK!"
                                  otherButtonTitles:nil];
            [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        }
    }
    [self.faceImageView performSelectorOnMainThread:@selector(setImage:) withObject:faceimage waitUntilDone:NO];
    
    [[NSOperationQueue mainQueue]addOperation:[NSBlockOperation blockOperationWithBlock:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }]];
}

- (IBAction)changLayout:(id)sender {
    if ((self.isfaceviewtop=!self.isfaceviewtop)) {
        [self.view bringSubviewToFront:self.bodyImageView];
    }else{
        [self.view bringSubviewToFront:self.faceImageView];
    }
}


- (UIImage*)clipImageWithRect:(CGRect)imagerect  andImage:(UIImage *)image  {
    CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], imagerect);
    UIImage *faceImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    return faceImage;
}

-(void)printLocation:(CGPoint)location{
    self.locationLabel.text = NSStringFromCGPoint(location);
}

@end
