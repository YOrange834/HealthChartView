//
//  ECGChartView.h
//  HealthChartView
//
//  Created by hrrMac on 2020/6/18.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ECGChartType) {
    ///只画一条线，画完以后清掉屏幕上的图做左边开始画
    ECGChartTypeOneLineJump,
    ///两条线，第一条画完之后，开始第二条收缩第一条
    ECGChartTypeTWOLineJump
};


@interface ECGChartView : UIView

///是否需要网格,默认需要
@property (assign, nonatomic) BOOL isShowGrid;

///一格(小格子)的大小，可以指定，也会有默认值
@property (assign, nonatomic) CGPoint oneGridPoint;

///大格字的颜色(一个大格字中有5个小格子)
@property (strong, nonatomic) UIColor *bigGridColor;

///小格字的颜色
@property (strong, nonatomic) UIColor *smallGridColor;

/**
 50 就是 一大格中会展示50个点的数据，一小个 也就是 10个点
 刷新的时间由用户自己控制，一般100毫秒（取25个点）也就是0.2s走一大格
 */
///X坐标的系数(传入电压在时间上的跨度) 默认50
@property (assign, nonatomic) CGFloat coefficientX;

///Y坐标的系数(传入的电压值转换成坐标的系数) 默认 2500(每格)
@property (assign, nonatomic) CGFloat coefficientY;

///默认ECGChartTypeTneLineJump
@property (assign, nonatomic) ECGChartType JumpType;

///刷新网格视图
-(void)reloadGrid;

///刷新配置信息
-(void)reloadConfig;

///画心电图
-(void)drawMap:(NSArray *)arr;

///两条线的画法
-(void)drawTwoLinwMap:(NSArray *)arr;

///一条线的画法
-(void)drawOneLinwMap:(NSArray *)arr;

///清楚数据
-(void)clearData;

@end

NS_ASSUME_NONNULL_END
