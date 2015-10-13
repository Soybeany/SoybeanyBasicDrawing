//
//  BasicDrawingPerformance.m
//  Drawing
//
//  Created by Soybeany on 15/8/10.
//  Copyright (c) 2015年 Soybeany. All rights reserved.
//

#import "BasicDrawingAppearance.h"

@implementation BasicDrawingAppearance

// 初始化时设定默认样式
- (instancetype)init{
    if (self = [super init]) {
        _width = 1;
        _borderColor = [UIColor blackColor];
        _contentColor = [UIColor whiteColor];
        _needToClose = NO;
        _drawingMode = kCGPathStroke;
        _lineJoin = kCGLineJoinRound;
        _lineCap = kCGLineCapRound;
        _alpha = 1;
        _dashSetting = @[];
    }
    return self;
}

- (BasicDrawingAppearance *)initWithWidth:(CGFloat)width borderColor:(UIColor *)borderColor contentColor:(UIColor *)contentColor needToClose:(BOOL)needToClose drawingMode:(CGPathDrawingMode)drawingMode lineJoin:(CGLineJoin)lineJoin lineCap:(CGLineCap)lineCap alpha:(CGFloat)alpha dashSetting:(NSArray *)dashSetting{
    if(self = [super init]){
        _width = width;
        _borderColor = borderColor;
        _contentColor = contentColor;
        _needToClose = needToClose;
        _drawingMode = drawingMode;
        _lineJoin = lineJoin;
        _lineCap = lineCap;
        _alpha = alpha;
        _dashSetting = dashSetting;
    }
    return self;
}

+ (BasicDrawingAppearance *)drawWithWidth:(CGFloat)width borderColor:(UIColor *)borderColor contentColor:(UIColor *)contentColor needToClose:(BOOL)needToClose drawingMode:(CGPathDrawingMode)drawingMode lineJoin:(CGLineJoin)lineJoin lineCap:(CGLineCap)lineCap alpha:(CGFloat)alpha dashSetting:(NSArray *)dashSetting{
    
    return [[BasicDrawingAppearance alloc] initWithWidth:width borderColor:borderColor contentColor:contentColor needToClose:needToClose drawingMode:drawingMode lineJoin:lineJoin lineCap:lineCap alpha:alpha dashSetting:dashSetting];
}

//- (void)dealloc{
//    NSLog(@"BDA");
//}

@end
