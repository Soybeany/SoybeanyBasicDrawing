//
//  BasicDrawing.h
//  Drawing
//
//  Created by Soybeany on 15/8/10.
//  Copyright (c) 2015年 Soybeany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicDrawingElement.h"
#import "BasicDrawingAppearance.h"

#define kMoveA(x, y) [[BasicDrawingElement alloc] initWithValue:[NSValue valueWithCGPoint:CGPointMake(x, y)] andElementType:moveType] // 移动到点(x, y)

#define kPointA(x, y) [[BasicDrawingElement alloc] initWithValue:[NSValue valueWithCGPoint:CGPointMake(x, y)] andElementType:lineType] // 记录点(x, y)

#define kRoundA(x, y, width, height) [[BasicDrawingElement alloc] initWithValue:[NSValue valueWithCGRect:CGRectMake((x)-width*0.5, (y)-height*0.5, width, height)] andElementType:roundType] // 记录椭圆(圆心x, 圆心y, 椭圆宽, 椭圆高)

#define kRectA(x, y, width, height) [[BasicDrawingElement alloc] initWithValue:[NSValue valueWithCGRect:CGRectMake(x, y, width, height)] andElementType:rectType] // 记录矩形(原点x, 原点y, 宽度, 高度)

#define kArcA(x, y, radius, startAngle, endAngle, clockwise) [[BasicDrawingElement alloc] initWithValue:[BasicDrawingElement transformArcType:ArcTypeMake(x, y, radius, (startAngle)*M_PI/180, (endAngle)*M_PI/180, clockwise)] andElementType:arcType] // 记录圆弧(圆心x, 圆心y, 圆半径, 开始角度, 结束角度, 是否逆时针)

#define kMoveB(x, y) [[BasicDrawingElement alloc] initWithValue:[NSValue valueWithCGPoint:CGPointMake(x, y)] andElementType:movePolarType] // 移动到点(x, y)

#define kMoveLineB(length, angle) [[BasicDrawingElement alloc] initWithValue:[NSValue valueWithCGPoint:CGPointMake(length, (angle)*M_PI/180)] andElementType:moveLinePolarType] // 移动到极坐标点(极径, 顺时针角度)

#define kPointB(x, y) [[BasicDrawingElement alloc] initWithValue:[NSValue valueWithCGPoint:CGPointMake(x, y)] andElementType:pointPolarType] // 记录点(x, y)

#define kLineB(length, angle) [[BasicDrawingElement alloc] initWithValue:[NSValue valueWithCGPoint:CGPointMake(length, (angle)*M_PI/180)] andElementType:linePolarType] // 记录极坐标点(极经, 顺时针角度)

#define kArcB(radius, centerAngle, offsetAngle, clockwise) [[BasicDrawingElement alloc] initWithValue:[NSValue valueWithCGRect:CGRectMake(radius, (centerAngle)*M_PI/180, (offsetAngle)*M_PI/180, clockwise)] andElementType:arcPolarType] // 记录极坐标圆弧(半径, 圆心逆时针偏转角度, 圆弧角度, 是否逆时针)

/*
 enum CGPathDrawingMode {
 kCGPathFill,
 kCGPathEOFill,
 kCGPathStroke,
 kCGPathFillStroke,
 kCGPathEOFillStroke
 };
*/

@protocol BasicDrawingViewDelegate;

@interface BasicDrawingView : UIView

@property (nonatomic) NSMutableArray *linesArr; /**<位置及类型元素*/
@property (nonatomic) id<BasicDrawingViewDelegate> delegate; /**<手势代理*/
@property (nonatomic) NSInteger status; /**<记录点击状态*/

/**
 *  基本的画线方法
 *
 *  @param linesArr   位置及类型元素
 *  @param appearance 元素的外观描述
 */
- (void)drawLines:(NSArray *)linesArr
       appearance:(BasicDrawingAppearance *)appearance;

/**
 *  快速构造出画板
 *
 *  @param frame 画板尺寸
 *
 *  @return 画板
 */
+ (BasicDrawingView *)basicDrawingViewWithFrame:(CGRect)frame;

/**
 *  重绘画面
 */
- (void)redraw;

@end

@protocol BasicDrawingViewDelegate <NSObject>

/**
 *  画板已点击
 *
 *  @param basicDrawingView 被点击的画板
 */
- (void)drawingViewDidTap:(BasicDrawingView *)basicDrawingView;

@end