//
//  Face83Position.m
//  LianKa
//
//  Created by tenghaojun on 15/11/18.
//  Copyright © 2015年 tenghaojun. All rights reserved.
//

#import "Face83Position.h"

@implementation Face83Position
-(NSMutableArray *)face83pArray{
    if(_face83pArray == nil){
        _face83pArray = [[NSMutableArray alloc]init];
    }
    return _face83pArray;
}

+(CGPoint)dicToPoint:(NSDictionary *)pointDic{
    CGPoint point;
    point.x = [(NSString *)pointDic[@"x"] floatValue];
    point.y = [(NSString *)pointDic[@"y"] floatValue];
    return point;
}

+(NSArray *)getPointArrayWithPointDictionaryArray:(NSArray *)pointDicArray{
    Face83Position *facePosition = [[Face83Position alloc]init];
    for (NSDictionary *dic in pointDicArray) {
        [facePosition.face83pArray addObject:[NSValue valueWithCGPoint:[self dicToPoint:dic]]];
    }
    return facePosition.face83pArray;
}
@end
