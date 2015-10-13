//
//  BasicDrawingCenter.m
//  Drawing
//
//  Created by Soybeany on 15/8/11.
//  Copyright (c) 2015年 Soybeany. All rights reserved.
//

#import "BasicDrawingCenter.h"

static BasicDrawingCenter *_basicDrawingCenter;

@implementation BasicDrawingCenter

+ (BasicDrawingCenter *)getInstance{
    if (!_basicDrawingCenter)
        _basicDrawingCenter = [BasicDrawingCenter new];
    return _basicDrawingCenter;
}

+ (void)discardInstance{
    if(_basicDrawingCenter)
        _basicDrawingCenter = nil;
}

//- (void)dealloc{
//    NSLog(@"BDC");
//}

@end
