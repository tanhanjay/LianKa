//
//  FaceImage.m
//  abc
//
//  Created by tenghaojun on 15/11/1.
//  Copyright © 2015年 tenghaojun. All rights reserved.
//

#import "FaceImageView.h"

@interface FaceImageView()
@property (nonatomic,assign)CGPoint beginPoint;

@end
@implementation FaceImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.beginPoint = [[touches anyObject]locationInView:self];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint pt = [[touches anyObject]locationInView:self];
    CGRect frame = [self frame];
    frame.origin.x += pt.x - self.beginPoint.x;
    frame.origin.y += pt.y - self.beginPoint.y;
    [self setFrame:frame];

}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(printLocation:)]) {
        
        [self.delegate printLocation: [self center]];
        
       
    }
}
@end
