//
//  Face83Position.h
//  LianKa
//
//  Created by tenghaojun on 15/11/18.
//  Copyright © 2015年 tenghaojun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FaceppAPI.h"
@interface Face83Position : NSObject


//此模块专门对FaceppSDK的标记83点方法返回的结果进行封装，每个关键点的类型为CGPoint，此位置是的单位为百分比，若为100之外的数，说明此点位置位于图外（Facepp对它进行了推断）


//83点
@property(nonatomic,assign) CGPoint contour_chin;
@property(nonatomic,assign) CGPoint contour_left1;
@property(nonatomic,assign) CGPoint contour_left2;
@property(nonatomic,assign) CGPoint contour_left3;
@property(nonatomic,assign) CGPoint contour_left4;

@property(nonatomic,assign) CGPoint contour_left5;
@property(nonatomic,assign) CGPoint contour_left6;
@property(nonatomic,assign) CGPoint contour_left7;
@property(nonatomic,assign) CGPoint contour_left8;
@property(nonatomic,assign) CGPoint contour_left9;


@property(nonatomic,assign) CGPoint contour_right1;
@property(nonatomic,assign) CGPoint contour_right2;
@property(nonatomic,assign) CGPoint contour_right3;
@property(nonatomic,assign) CGPoint contour_right4;
@property(nonatomic,assign) CGPoint contour_right5;

@property(nonatomic,assign) CGPoint contour_right6;
@property(nonatomic,assign) CGPoint contour_right7;
@property(nonatomic,assign) CGPoint contour_right8;
@property(nonatomic,assign) CGPoint contour_right9;
@property(nonatomic,assign) CGPoint left_eye_bottom;


@property(nonatomic,assign) CGPoint left_eye_center;
@property(nonatomic,assign) CGPoint left_eye_left_corner;
@property(nonatomic,assign) CGPoint left_eye_lower_left_quarter;
@property(nonatomic,assign) CGPoint left_eye_lower_right_quarter;
@property(nonatomic,assign) CGPoint left_eye_pupil;

@property(nonatomic,assign) CGPoint left_eye_right_corner;
@property(nonatomic,assign) CGPoint left_eye_top;
@property(nonatomic,assign) CGPoint left_eye_upper_left_quarter;
@property(nonatomic,assign) CGPoint left_eye_upper_right_quarter;
@property(nonatomic,assign) CGPoint left_eyebrow_left_corner;


@property(nonatomic,assign) CGPoint left_eyebrow_lower_left_quarter;
@property(nonatomic,assign) CGPoint left_eyebrow_lower_middle;
@property(nonatomic,assign) CGPoint left_eyebrow_lower_right_quarter;
@property(nonatomic,assign) CGPoint left_eyebrow_right_corner;
@property(nonatomic,assign) CGPoint left_eyebrow_upper_left_quarter;

@property(nonatomic,assign) CGPoint left_eyebrow_upper_middle;
@property(nonatomic,assign) CGPoint left_eyebrow_upper_right_quarter;
@property(nonatomic,assign) CGPoint mouth_left_corner;
@property(nonatomic,assign) CGPoint mouth_lower_lip_bottom;
@property(nonatomic,assign) CGPoint mouth_lower_lip_left_contour1;


@property(nonatomic,assign) CGPoint mouth_lower_lip_left_contour2;
@property(nonatomic,assign) CGPoint mouth_lower_lip_left_contour3;
@property(nonatomic,assign) CGPoint mouth_lower_lip_right_contour1;
@property(nonatomic,assign) CGPoint mouth_lower_lip_right_contour2;
@property(nonatomic,assign) CGPoint mouth_lower_lip_right_contour3;

@property(nonatomic,assign) CGPoint mouth_lower_lip_top;
@property(nonatomic,assign) CGPoint mouth_right_corner;
@property(nonatomic,assign) CGPoint mouth_upper_lip_bottom;
@property(nonatomic,assign) CGPoint mouth_upper_lip_left_contour1;
@property(nonatomic,assign) CGPoint mouth_upper_lip_left_contour2;


@property(nonatomic,assign) CGPoint mouth_upper_lip_left_contour3;
@property(nonatomic,assign) CGPoint mouth_upper_lip_right_contour1;
@property(nonatomic,assign) CGPoint mouth_upper_lip_right_contour2;
@property(nonatomic,assign) CGPoint mouth_upper_lip_right_contour3;
@property(nonatomic,assign) CGPoint mouth_upper_lip_top;

@property(nonatomic,assign) CGPoint nose_contour_left1;
@property(nonatomic,assign) CGPoint nose_contour_left2;
@property(nonatomic,assign) CGPoint nose_contour_left3;
@property(nonatomic,assign) CGPoint nose_contour_lower_middle;
@property(nonatomic,assign) CGPoint nose_contour_right1;


@property(nonatomic,assign) CGPoint nose_contour_right2;
@property(nonatomic,assign) CGPoint nose_contour_right3;
@property(nonatomic,assign) CGPoint nose_left;
@property(nonatomic,assign) CGPoint nose_right;
@property(nonatomic,assign) CGPoint nose_tip;

@property(nonatomic,assign) CGPoint right_eye_bottom;
@property(nonatomic,assign) CGPoint right_eye_center;
@property(nonatomic,assign) CGPoint right_eye_left_corner;
@property(nonatomic,assign) CGPoint right_eye_lower_left_quarter;
@property(nonatomic,assign) CGPoint right_eye_lower_right_quarter;


@property(nonatomic,assign) CGPoint right_eye_pupil;
@property(nonatomic,assign) CGPoint right_eye_right_corner;
@property(nonatomic,assign) CGPoint right_eye_top;
@property(nonatomic,assign) CGPoint right_eye_upper_left_quarter;
@property(nonatomic,assign) CGPoint right_eye_upper_right_quarter;

@property(nonatomic,assign) CGPoint right_eyebrow_left_corner;
@property(nonatomic,assign) CGPoint right_eyebrow_lower_left_quarter;
@property(nonatomic,assign) CGPoint right_eyebrow_lower_middle;
@property(nonatomic,assign) CGPoint right_eyebrow_lower_right_quarter;
@property(nonatomic,assign) CGPoint right_eyebrow_right_corner;


@property(nonatomic,assign) CGPoint right_eyebrow_upper_left_quarter;
@property(nonatomic,assign) CGPoint right_eyebrow_upper_middle;
@property(nonatomic,assign) CGPoint right_eyebrow_upper_right_quarter;

//得到landmark83Postion实例的类方法
+(instancetype)getInstanceWithFaceppResult:(FaceppResult *)landmark83PResult;

@end
