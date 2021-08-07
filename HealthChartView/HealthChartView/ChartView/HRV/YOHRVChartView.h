//
//  YOHRVChartView.h
//  HealthChartView
//
//  Created by HOrange on 2021/8/7.
//  Copyright © 2021 HOrange. All rights reserved.
//

#import "YOBaseChartView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YOHRVChartView : YOBaseChartView

@property (strong, nonatomic) NSArray *dataArr;

-(void)reload;

@end

NS_ASSUME_NONNULL_END
