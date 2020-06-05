//
//  YOBaseChartView.h
//  DawnHealth
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 hheTeamiOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YOXAxis.h"
#import "YOYAxis.h"

#import "YOChartViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YOBaseChartView : UIView

///X轴相关参数设置
@property (strong, nonatomic) YOXAxis *xAxis;

///X轴相关参数设置
@property (strong, nonatomic) YOYAxis *yAxis;

///界面相关间距等设置
@property (strong, nonatomic) YOChartViewModel *model;

///画X轴的刻度
-(void)drawXLabel;

///画XY轴两条线
-(void)drawAxsiLine;

///清除视图
-(void)cleanView:(NSMutableArray *)arr;

///先清除后添加
-(void)refreshXY;

@end

NS_ASSUME_NONNULL_END
