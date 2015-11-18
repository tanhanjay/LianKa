//
//  Face83Position.h
//  LianKa
//
//  Created by tenghaojun on 15/11/18.
//  Copyright © 2015年 tenghaojun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Face83Position : NSObject
@property(nonatomic,strong) NSMutableArray *face83pArray;
+(instancetype)getInstanceWithPointDictionaryArray:(NSArray *)pointDicArray;
@end
