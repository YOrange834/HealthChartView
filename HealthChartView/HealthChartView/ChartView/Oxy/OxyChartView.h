//
//  OxyChartView.h
//  HealthChartView
//
//  Created by MAC on 2020/12/26.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "YOBaseChartView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OxyChartView : YOBaseChartView


@property (strong, nonatomic) NSArray *dataArr;

@property (strong, nonatomic) NSArray *puseArr;

-(void)reload;

@end

NS_ASSUME_NONNULL_END
