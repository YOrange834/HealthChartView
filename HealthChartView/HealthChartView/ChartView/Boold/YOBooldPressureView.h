//
//  YOBooldPressure.h
//  HealthChartView
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "YOBaseChartView.h"
#import "YOBPValueModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YOBooldPressureView : YOBaseChartView

///最多展示多少条数据，和X轴的刻度数量不一定要对应，默认为1
@property (assign, nonatomic) UInt8 number;

@property (strong, nonatomic) NSArray <YOBPValueModel *>*dataArr;

///是否显示血压范围，默认显示（60-90 90-140）
@property (assign, nonatomic) BOOL isNeedShowRange;

///收缩压的背景颜色，低压
@property (strong, nonatomic) UIColor *systoleColor;

///舒张压的背景色
@property (strong, nonatomic) UIColor *diastolicColor;


-(void)reload;

@end

NS_ASSUME_NONNULL_END
