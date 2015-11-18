//
//  FaceDetecteViewController.m
//  HereHairAPP
//
//  Created by tenghaojun on 15/10/21.
//  Copyright © 2015年 tenghaojun. All rights reserved.
//

#import "FaceDetecteViewController.h"
#import "FaceppAPI.h"
#import "APIKey+APISecret.h"
#import "MBProgressHUD.h"
@interface FaceDetecteViewController ()

@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bodyImageVIew;

@end

@implementation FaceDetecteViewController

// 懒加载
- (UIImagePickerController *)imagePicker
{
    if (!_imagePicker ) {
        _imagePicker = [[UIImagePickerController alloc]init];
    }
    return _imagePicker;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // initialize
    NSString *API_KEY = _API_KEY;
    NSString *API_SECRET = _API_SECRET;
    
    [FaceppAPI initWithApiKey:API_KEY andApiSecret:API_SECRET andRegion:APIServerRegionCN];
    [FaceppAPI setDebugMode:YES];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)librarybtnpress:(id)sender {
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
- (IBAction)camerabtnpress:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
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



// Use facepp SDK to detect faces
-(void) detectWithImage: (UIImage*) image {
    
    
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

                NSOperationQueue *mainqueue = [NSOperationQueue mainQueue];
                [mainqueue addOperationWithBlock:^{
                    [self clipImageWithRect:rect andPostion:CGPointMake(100 ,120 ) andImage:image andTargetImageView:self.faceImageView andScale:height/width];
                }];

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
}
//裁剪脸部图
- (void)clipImageWithRect:(CGRect)imagerect andPostion:(CGPoint)imageposition andImage:(UIImage *)image andTargetImageView:(UIImageView *)imageView andScale:(float)scale{
//    imageView.frame = CGRectMake(imageposition.x, imageposition.y, imagerect.size.width, imagerect.size.height);
    CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], imagerect);
    imageView.image = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
//    imageView.frame = CGRectMake(120, 100, 100, 100);
//    UIImageView *bodyimageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 100, 300, 400)];
//    bodyimageView.image = [UIImage imageNamed:@"吴彦祖抠脸"];
//    [self.view addSubview:bodyimageView];
    [self.view bringSubviewToFront:self.bodyImageVIew];
}
- (IBAction)backButtonAction:(id)sender {
   [ self dismissViewControllerAnimated:YES completion:^{
        
   }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    UIImage *sourceImage = info[UIImagePickerControllerOriginalImage];
    UIImage *imageToDisplay = [self fixOrientation:sourceImage];
    
    // perform detection in background thread
    [self performSelectorInBackground:@selector(detectWithImage:) withObject:imageToDisplay ];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}




- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}



@end
