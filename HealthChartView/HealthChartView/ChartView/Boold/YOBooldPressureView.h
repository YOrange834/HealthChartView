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

-(void)reload;

@end

NS_ASSUME_NONNULL_END
