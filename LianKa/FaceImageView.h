//
//  FaceImage.h
//  abc
//
//  Created by tenghaojun on 15/11/1.
//  Copyright © 2015年 tenghaojun. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FaceImageViewDelegate <NSObject>
@optional
- (void)printLocation:(CGPoint)location;

@end

@interface FaceImageView : UIImageView
@property (nonatomic,weak)id <FaceImageViewDelegate>delegate;
@end

