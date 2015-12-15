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

//此类是自主DIY功能模块的视图控制器（UIViewController）
/**
 简单介绍一下该模块的流程：首先用户拍照或选相册照片，选好按下去顶之后就调用findPositionAndSize来寻找图片上人的眼睛的位置和确定素材框的位置和大小，结束之后的结果是在恰当的位置有一个合适大小的素材UIImageView，
 每当按下对应的素材按钮，素材UIimageView的image会随之改变
 */

@interface dressSimulateVC()<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    UIImageView *_imageView;
    UIView *_srcParentView;
    UIImagePickerController *_imagePicker;
    FaceppResult *_result;
}
@property(nonatomic,strong)UIImageView *srcpicView;
@property(nonatomic,strong)NSArray *srcimgsArray;
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
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((screenWidth-300)/2.0, 100, 300, 300)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_imageView];
    
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
        _srcParentView = [[UIView alloc]initWithFrame:_imageView.frame];
        [self.view addSubview:_srcParentView];
    }
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initLayout];
    self.srcimgsArray = @[@"1.png",@"2.png",@"3.png",@"4.png"];
}

-(UIImageView*)srcpicView{
    if (_srcpicView==nil) {
        _srcpicView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        [_srcParentView addSubview:_srcpicView];
    }
    return _srcpicView;
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
    [self showSrcpicImageView:btn.tag];
}


//找到眼镜的位置以便确定素材放的位置
-(void)findPositionAndSize{
    CGPoint eyeleft,eyeright,srcpicCenterPostion;
    float imageWidth = [_result.content[@"img_width"]floatValue];
    float imageHeight = [_result.content[@"img_height"]floatValue];
    eyeleft.x =[_result.content[@"face"][0][@"position"][@"eye_left"][@"x"] floatValue];
    eyeleft.y =[_result.content[@"face"][0][@"position"][@"eye_left"][@"y"] floatValue];
    eyeright.x = [_result.content[@"face"][0][@"position"][@"eye_right"][@"x"] floatValue];
    eyeright.y = [_result.content[@"face"][0][@"position"][@"eye_right"][@"y"] floatValue];
    float viewWidht,viewHeight;
    CGPoint startPoint;
    if (imageHeight>imageWidth) {
        viewHeight=300;
        viewWidht= imageWidth/imageHeight*300;
        startPoint.y = 0;
        startPoint.x = (300-viewWidht)/2.0f;
    }else{
        viewWidht = 300;
        viewHeight = imageHeight/imageWidth;
        startPoint.x = 0;
        startPoint.y = (300-viewHeight)/2.0f;
    }
    srcpicCenterPostion.x = (eyeright.x+eyeleft.x)*0.5*viewWidht*0.01f+startPoint.x;
    srcpicCenterPostion.y = (eyeright.y+eyeleft.y)*0.5*viewHeight*0.01f+startPoint.y;
    float srcpicwidth = (eyeright.x - eyeleft.x)*0.01f*viewWidht/0.7;
   
    
    self.srcpicView.frame = CGRectMake(0, 0, srcpicwidth, srcpicwidth);
    self.srcpicView.center = srcpicCenterPostion;
    
}

-(void)showSrcpicImageView:(NSInteger)tag{
    UIImage *image = [UIImage imageNamed:self.srcimgsArray[tag-1]];
    self.srcpicView.image = image;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:^{
        MyFaceDection *facedetection = [[MyFaceDection alloc]init];
        _result = [facedetection faceDetectionWithImage:image];

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //检查人脸识别是否成功
        if(_result.success){
            [self findPositionAndSize];
             _imageView.image = image;
        }else{
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"出错啦！" message:@"无法识别出人脸，请换一张照片试一试" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertChangeAction = [UIAlertAction actionWithTitle:@"重选照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self presentViewController:_imagePicker animated:YES completion:nil];
            }];
            [alertC addAction:alertChangeAction];
            UIAlertAction *alertCancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertC addAction:alertCancleAction];
            [self presentViewController:alertC animated:YES completion:nil];
        }
    }];
    
}

@end
