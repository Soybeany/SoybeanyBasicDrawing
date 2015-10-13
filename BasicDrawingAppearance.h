//
//  BasicDrawingPerformance.h
//  Drawing
//
//  Created by Soybeany on 15/8/10.
//  Copyright (c) 2015年 Soybeany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicDrawingAppearance : NSObject

@property (nonatomic) CGFloat width; /**<线条宽度*/
@property (nonatomic) UIColor *borderColor; /**<边框颜色*/
@property (nonatomic) UIColor *contentColor; /**<填充颜色*/
@property (nonatomic) BOOL needToClose; /**<是否需要闭合*/
@property (nonatomic) CGPathDrawingMode drawingMode; /**<绘图样式,如描边,填充,填充描边*/
@property (nonatomic) CGLineJoin lineJoin; /**<线段连接样式*/
@property (nonatomic) CGLineCap lineCap; /**<线段末端样式*/
@property (nonatomic) CGFloat alpha; /**<线条透明度*/
@property (nonatomic) NSArray *dashSetting; /**<虚线样式*/

/**
 *  初始化视图
 *
 *  @param width        线条宽度
 *  @param borderColor  边框颜色
 *  @param contentColor 填充颜色
 *  @param needToClose  是否需要闭合
 *  @param drawingMode  绘图样式,如描边,填充,填充描边
 *  @param lineJoin     线段连接样式
 *  @param lineCap      线段末端样式
 *  @param alpha        线条透明度
 *  @param dashSetting  虚线样式
 *
 *  @return 绘图外观
 */
- (BasicDrawingAppearance *)initWithWidth:(CGFloat)width
                                    borderColor:(UIColor *)borderColor
                                  contentColor:(UIColor *)contentColor
                              needToClose:(BOOL)needToClose
                             drawingMode:(CGPathDrawingMode)drawingMode
                                 lineJoin:(CGLineJoin)lineJoin
                                  lineCap:(CGLineCap)lineCap
                                    alpha:(CGFloat)alpha
                              dashSetting:(NSArray *)dashSetting;

/**
 *  初始化视图
 *
 *  @param width        线条宽度
 *  @param borderColor  边框颜色
 *  @param contentColor 填充颜色
 *  @param needToClose  是否需要闭合
 *  @param drawingMode  绘图样式,如描边,填充,填充描边
 *  @param lineJoin     线段连接样式
 *  @param lineCap      线段末端样式
 *  @param alpha        线条透明度
 *  @param dashSetting  虚线样式
 *
 *  @return 绘图外观
 */
+ (BasicDrawingAppearance *)drawWithWidth:(CGFloat)width
                              borderColor:(UIColor *)borderColor
                             contentColor:(UIColor *)contentColor
                              needToClose:(BOOL)needToClose
                              drawingMode:(CGPathDrawingMode)drawingMode
                                 lineJoin:(CGLineJoin)lineJoin
                                  lineCap:(CGLineCap)lineCap
                                    alpha:(CGFloat)alpha
                              dashSetting:(NSArray *)dashSetting;

@end
