//
//  BasicDrawingElement.h
//  Drawing
//
//  Created by Soybeany on 15/8/10.
//  Copyright (c) 2015年 Soybeany. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义元素类型
typedef enum : NSUInteger {
    moveType,
    lineType,
    roundType,
    rectType,
    arcType,
    movePolarType,
    moveLinePolarType,
    pointPolarType,
    linePolarType,
    arcPolarType,
} ElementType;

// 定义圆弧类型
typedef struct {
    CGFloat x;
    CGFloat y;
    CGFloat radius;
    CGFloat startAngle;
    CGFloat endAngle;
    int clockwise;
} ArcType;

/**
 *  增加快速设定圆弧的函数
 *
 *  @param x          圆心x
 *  @param y          圆心y
 *  @param radius     圆半径
 *  @param startAngle 开始角度
 *  @param endAngle   结束角度
 *  @param clockwise  是否逆时针
 *
 *  @return 圆弧类型
 */
CG_INLINE ArcType
ArcTypeMake(CGFloat x, CGFloat y, CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
{
    ArcType arcType;
    arcType.x = x; arcType.y = y;
    arcType.radius = radius; arcType.startAngle = startAngle; arcType.endAngle = endAngle; arcType.clockwise = clockwise;
    return arcType;
}

@class BasicDrawingAppearance;

@interface BasicDrawingElement : NSObject

@property (nonatomic) NSValue *value; /**<封装起每个元素*/
@property (nonatomic) ElementType elementType; /**<记录元素的类型, 如点,圆,矩形,圆弧等*/
@property (nonatomic) BasicDrawingAppearance *appearance; /**<记录图形的外观*/

/**
 *  初始化元素
 *
 *  @param value       元素
 *  @param elementType 元素类型
 *
 *  @return 元素
 */
- (BasicDrawingElement *)initWithValue:(NSValue *)value andElementType:(ElementType)elementType;

/**
 *  将弧度类型转换为NSValue类型
 *
 *  @param arcType 弧度类型
 *
 *  @return NSValue类型
 */
+ (NSValue *)transformArcType:(ArcType)arcType;

@end
