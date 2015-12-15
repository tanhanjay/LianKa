//
//  MyFaceDection.h
//  LianKa
//
//  Created by tenghaojun on 15/12/8.
//  Copyright © 2015年 tenghaojun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "APIKey+APISecret.h"
#import "FaceppAPI.h"
#import "Face83Position.h"


//此模块用于人脸检测,是我自己对FaceppSDK的进一步封装（为了此项目方便的使用），只需要传入UIImage类型的对象即可得到FaceppResult或我自己封装的Face83Postion的返回值
/**注意：1.本模块返回的结果只是对图片里只有一个人的检测，多个人也只能检测并返回一个人的结果，并不适合多个人的识别
 2.错误处理的时候，我没有考虑错误的原因，如果图片中的人脸比较难以辨别而没有检测出来，或是图片中没有人脸，或网络连接错误，都会使得FaceppResult对象的success属性为NO，
    调用landmark……的方法时，如果错误，返回的Face83Postion为nil
 */
@interface MyFaceDection : UIViewController
- (FaceppResult *)faceDetectionWithImage:(UIImage *)image;
- (Face83Position *)landmark83PfaceImage:(UIImage *)image;
@end
