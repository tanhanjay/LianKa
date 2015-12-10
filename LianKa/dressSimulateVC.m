 //
//  dressSimulateVC.m
//  LianKa
//
//  Created by tenghaojun on 15/12/8.
//  Copyright © 2015年 tenghaojun. All rights reserved.
//

#import "dressSimulateVC.h"
#import "faceppAPI.h"
#import "MBProgressHUD.h"
#import "MyFaceDection.h"
@interface dressSimulateVC()<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    UIImageView *_imageview;
    UIImagePickerController *_imagePicker;
    FaceppResult *_result;
}

@end
@implementation dressSimulateVC
//初始化布局
-(void)initLayout{
    int screenWidth = [[UIScreen mainScreen]bounds].size.width;
    
    UIButton *cameraBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [cameraBtn setTitle:@"相机" forState:UIControlStateNormal];
    cameraBtn.frame = CGRectMake(20, 20, 80, 40);
    [cameraBtn addTarget:self action:@selector(carmeraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraBtn];
    
    UIButton *photolibBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [photolibBtn setTitle:@"相册" forState:UIControlStateNormal];
    photolibBtn.frame = CGRectMake(screenWidth-20-80, 20, 80, 40);
    [photolibBtn addTarget:self action:@selector(photolibBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photolibBtn];
    
    _imagePicker = [[UIImagePickerController alloc]init];
    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake((screenWidth-300)/2.0, 100, 300, 300)];
    _imageview.contentMode = UIViewContentModeScaleAspectFit;
    _imageview.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_imageview];
    
    for (int i =0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
     
        int margin = 20;
        int width = (screenWidth - 5*margin)/4;
        btn.frame = CGRectMake(margin+(margin+width)*i, 420, width, width);
        NSString *imageName = [NSString stringWithFormat:@"%d.png",i+1];
        UIImageView *btnImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, width-20, width-20)];
        btnImageView.contentMode = UIViewContentModeScaleAspectFit;
        btnImageView.image = [UIImage imageNamed:imageName];
        btn.tag=(i+1);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn addSubview:btnImageView];
        [self.view addSubview:btn];
    }
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initLayout];
}

-(void)carmeraBtnClick:(UIButton *)btn{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        _imagePicker.delegate = self;
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"failed to camera";
        [hud show:YES];
        [hud performSelector:@selector(hide:) withObject:@YES afterDelay:2];
        
    }
}

-(void)photolibBtnClick:(UIButton *)btn{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        
        _imagePicker.delegate = self;
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:_imagePicker animated:YES completion:^{
            
        }];
    }
    else {
        MBProgressHUD *hud = [[MBProgressHUD alloc]init];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"failed to access photo library";
        [hud show:YES];
        
    }
}

-(void)btnClick:(UIButton *)btn{
    
}

-(void)findPosition{
    CGPoint eyeleft;
    eyeleft.x =[_result.content[@"face"][@"position"][@"eye_left"][@"x"] floatValue];
    eyeleft.y =[_result.content[@"face"][@"position"][@"eye_left"][@"y"] floatValue];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:^{
        MyFaceDection *facedetection = [[MyFaceDection alloc]init];
        _result = [facedetection faceDetectionWithImage:image];
        _imageview.image = image;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

@end
