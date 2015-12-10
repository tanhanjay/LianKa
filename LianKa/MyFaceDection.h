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
@interface MyFaceDection : UIViewController
- (FaceppResult *)faceDetectionWithImage:(UIImage *)image;
@end
