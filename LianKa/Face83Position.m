//
//  Face83Position.m
//  LianKa
//
//  Created by tenghaojun on 15/11/18.
//  Copyright © 2015年 tenghaojun. All rights reserved.
//

#import "Face83Position.h"


@implementation Face83Position

+(instancetype)getInstanceWithFaceppResult:(FaceppResult *)landmark83PResult{
    Face83Position *face83PositonInstance = [[Face83Position alloc]init];
    [face83PositonInstance LandmarkResultToModelWithResult:landmark83PResult];
    return face83PositonInstance;
}

-(CGPoint)dicToPoint:(NSDictionary *)pointDic{
    CGPoint point;
    point.x = [(NSString *)pointDic[@"x"] floatValue];
    point.y = [(NSString *)pointDic[@"y"] floatValue];
    return point;
}

-(void)LandmarkResultToModelWithResult:(FaceppResult*)landmark83PResult{
    NSDictionary *landmark83pointsDic = landmark83PResult.content[@"result"][0][@"landmark"];

    NSArray * face83pKeyArray = [landmark83pointsDic allKeys];
    for (NSString *positionKey in face83pKeyArray) {
        
        NSLog(@"%@",[landmark83pointsDic valueForKey:positionKey]);
        NSDictionary *positionDic = [landmark83pointsDic valueForKey:positionKey];
        CGPoint point = [self dicToPoint:positionDic];
        [self setValue:[NSValue valueWithCGPoint:point] forKey:positionKey];
    }
}



@end
