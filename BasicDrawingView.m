//
//  BasicDrawing.m
//  Drawing
//
//  Created by Soybeany on 15/8/10.
//  Copyright (c) 2015年 Soybeany. All rights reserved.
//

#import "BasicDrawingView.h"
#import "BasicDrawingCenter.h"

@interface BasicDrawingView ()

@end

@implementation BasicDrawingView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor]; // 使背景透明
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(drawingViewDidTap:)]];
    }
    return self;
}

+ (BasicDrawingView *)basicDrawingViewWithFrame:(CGRect)frame{
    return [[BasicDrawingView alloc] initWithFrame:frame];
}

- (void)drawLines:(NSArray *)linesArr appearance:(BasicDrawingAppearance *)appearance{
    if(!_linesArr)
        _linesArr = [NSMutableArray new]; // 没有时就创建可变数组
    for (int i = 0; i < linesArr.count; i++) {
        [linesArr[i] setAppearance:appearance]; // 为每个点设置外观属性,只设定第一个也行,顺手全设定而已
    }
    [_linesArr addObject:linesArr];
}

- (void)drawingViewDidTap:(UIGestureRecognizer *)gestureRecognizer{
    [_delegate drawingViewDidTap:self];
}

- (void)redraw{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext(); /**<获得图形上下文*/
    
    for(int i = 0; i < _linesArr.count; i++){
        
        if([_linesArr[i] count]){
            NSArray *elementsArr = _linesArr[i]; // 获得第i个完整图形
            
            BasicDrawingElement *firstElement = elementsArr[0];
            
            const NSUInteger dashCount = [firstElement appearance].dashSetting.count;
            CGFloat dash[dashCount];
            for (int i = 0; i < dashCount; i++) {
                dash[i] = [[firstElement appearance].dashSetting[i] floatValue];
            }
            
            CGFloat redB, redC, greenB, greenC, blueB, blueC, alphaB, alphaC;
            [[firstElement appearance].borderColor getRed:&redB green:&greenB blue:&blueB alpha:&alphaB];
            [[firstElement appearance].contentColor getRed:&redC green:&greenC blue:&blueC alpha:&alphaC];
            CGContextSetRGBStrokeColor(ctx, redB, greenB, blueB, alphaB); // 设置边框颜色
            CGContextSetRGBFillColor(ctx, redC, greenC, blueC, alphaC); // 设置填充颜色
            CGContextSetLineJoin(ctx, [firstElement appearance].lineJoin); // 设置线段转折的样式
            CGContextSetLineCap(ctx, [firstElement appearance].lineCap); // 设置线段末端的样式
            CGContextSetLineWidth(ctx, [firstElement appearance].width); //设置线条的宽度
            CGContextSetAlpha(ctx, [firstElement appearance].alpha); // 设置线条的透明度
            CGContextSetLineDash(ctx, 0, dash, dashCount); // 设置虚线的样式
            
            if([firstElement elementType] == lineType || [firstElement elementType] == pointPolarType){
                CGPoint firstPoint = [[(BasicDrawingElement *)firstElement value] CGPointValue];
                CGContextMoveToPoint(ctx, firstPoint.x, firstPoint.y); // 首个是点的话就移动
                
                if([firstElement elementType] == pointPolarType)
                    [BasicDrawingCenter getInstance].lastPosition = CGPointMake(firstPoint.x, firstPoint.y);
            }
            else if ([firstElement elementType] == linePolarType){
                CGPoint firstPoint = [[(BasicDrawingElement *)firstElement value] CGPointValue];
                CGPoint lastPoint = CGPointMake(firstPoint.x*cos(firstPoint.y), firstPoint.x*sin(firstPoint.y));
                CGContextMoveToPoint(ctx, lastPoint.x, lastPoint.y); // 首个是点的话就移动
                [BasicDrawingCenter getInstance].lastPosition = lastPoint;
                [BasicDrawingCenter getInstance].lastAngle = firstPoint.y;
            }            
            
            for(int j = ([firstElement elementType] == lineType || [firstElement elementType] == pointPolarType || [firstElement elementType] == linePolarType ? 1 : 0); j < elementsArr.count; j++){
                BasicDrawingElement *element = (BasicDrawingElement *)elementsArr[j];
                switch (element.elementType) {
                    case moveType:{ // 移动点
                        CGPoint otherPoint = [element.value CGPointValue];
                        CGContextMoveToPoint(ctx, otherPoint.x, otherPoint.y);
                    }
                        break;
                        
                    case lineType:{ // 线段
                        CGPoint otherPoint = [element.value CGPointValue];
                        CGContextAddLineToPoint(ctx, otherPoint.x, otherPoint.y);
                    }
                        break;
                        
                    case roundType:{ // 椭圆
                        CGRect otherRect = [element.value CGRectValue];
                        CGContextAddEllipseInRect(ctx, otherRect);
                    }
                        break;
                        
                    case rectType:{ // 矩形
                        CGRect otherRect = [element.value CGRectValue];
                        CGContextAddRect(ctx, otherRect);
                    }
                        break;
                        
                    case arcType:{ // 圆弧
                        ArcType otherArc = {0};
                        [element.value getValue:&otherArc];
                        CGContextAddArc(ctx, otherArc.x, otherArc.y, otherArc.radius, otherArc.startAngle, otherArc.endAngle, otherArc.clockwise);
                    }
                        break;
                        
                    case movePolarType:{ // 移动点
                        CGPoint otherPoint = [element.value CGPointValue];
                        CGContextMoveToPoint(ctx, otherPoint.x, otherPoint.y);
                        [BasicDrawingCenter getInstance].lastPosition = CGPointMake(otherPoint.x, otherPoint.y);
                        [BasicDrawingCenter getInstance].lastAngle = 0;
                    }
                        break;
                        
                    case moveLinePolarType:{ // 移动极坐标点
                        CGPoint otherPoint = [element.value CGPointValue];
                        CGPoint lastPoint = [BasicDrawingCenter getInstance].lastPosition;
                        CGFloat lastAngle = [BasicDrawingCenter getInstance].lastAngle;
                        CGFloat currentAngle = otherPoint.y+lastAngle;
                        CGPoint currentPoint = CGPointMake(lastPoint.x+otherPoint.x*cos(currentAngle), lastPoint.y+otherPoint.x*sin(currentAngle));
                        CGContextMoveToPoint(ctx, currentPoint.x, currentPoint.y);
                        [BasicDrawingCenter getInstance].lastPosition = currentPoint;
                        [BasicDrawingCenter getInstance].lastAngle = currentAngle;
                    }
                        break;
                        
                    case pointPolarType:{ // 极坐标点
                        CGPoint otherPoint = [element.value CGPointValue];
                        CGPoint lastPoint = [BasicDrawingCenter getInstance].lastPosition;
                        CGContextAddLineToPoint(ctx, otherPoint.x, otherPoint.y);
                        CGFloat length = sqrt(pow(otherPoint.x-lastPoint.x, 2)+pow(otherPoint.y-lastPoint.y, 2));
                        [BasicDrawingCenter getInstance].lastPosition = otherPoint;
                        [BasicDrawingCenter getInstance].lastAngle = asin((otherPoint.y-lastPoint.y)/length);
                    }
                        break;
                        
                    case linePolarType:{ // 极坐标线段
                        CGPoint otherPoint = [element.value CGPointValue];
                        CGPoint lastPoint = [BasicDrawingCenter getInstance].lastPosition;
                        CGFloat lastAngle = [BasicDrawingCenter getInstance].lastAngle;
                        CGFloat currentAngle = otherPoint.y+lastAngle;
                        CGPoint currentPoint = CGPointMake(lastPoint.x+otherPoint.x*cos(currentAngle), lastPoint.y+otherPoint.x*sin(currentAngle));
                        CGContextAddLineToPoint(ctx, currentPoint.x, currentPoint.y);
                        [BasicDrawingCenter getInstance].lastPosition = currentPoint;
                        [BasicDrawingCenter getInstance].lastAngle = currentAngle;
                    }
                        break;
                        
                    case arcPolarType:{ // 极坐标圆弧 (圆心x, 圆心y, 角度)
                        CGRect otherRect = [element.value CGRectValue];
                        CGPoint lastPoint = [BasicDrawingCenter getInstance].lastPosition;
                        CGFloat lastAngle = [BasicDrawingCenter getInstance].lastAngle;
                        CGFloat radius = otherRect.origin.x;
                        CGFloat centerAngle = lastAngle + otherRect.origin.y;
                        CGPoint centerPoint = CGPointMake(lastPoint.x+radius*cos(centerAngle), lastPoint.y+radius*sin(centerAngle));
//                        NSLog(@"lastPoint:%@ LastAngle:%f centerAngle:%f centerPoint:%@", NSStringFromCGPoint(lastPoint), lastAngle*180/M_PI, centerAngle*180/M_PI, NSStringFromCGPoint(centerPoint));                        
                        CGFloat asinAngle = asin((lastPoint.y-centerPoint.y)/radius);
                        CGFloat currentStartAngle = (lastPoint.x>centerPoint.x?asinAngle:lastPoint.y<centerPoint.y?-M_PI-asinAngle:M_PI-asinAngle);
                        CGFloat currentEndAngle = otherRect.size.height == 0 ? currentStartAngle + otherRect.size.width : currentStartAngle - otherRect.size.width;
                        CGPoint currentEndPoint = CGPointMake(centerPoint.x+radius*cos(currentEndAngle), centerPoint.y+radius*sin(currentEndAngle));
                        CGContextAddArc(ctx, centerPoint.x, centerPoint.y, radius, currentStartAngle, currentEndAngle, otherRect.size.height);
                        [BasicDrawingCenter getInstance].lastPosition = currentEndPoint;
                        [BasicDrawingCenter getInstance].lastAngle = otherRect.size.height == 0 ? currentEndAngle + M_PI/2 : currentEndAngle - M_PI/2;
                    }
                        break;
                        
                    default:
                        break;
                }
            }
            
            if([firstElement appearance].needToClose){
                CGContextClosePath(ctx); // 是否需要闭合路径
            }

            CGContextDrawPath(ctx, [firstElement appearance].drawingMode); // 开始绘图
            [BasicDrawingCenter getInstance].lastAngle = 0; // 每次新的笔画都需要将角度清零
        }
    }
    [_linesArr removeAllObjects];
    [BasicDrawingCenter discardInstance];
}

@end
