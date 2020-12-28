//
//  SleepValueModel.h
//  HealthChartView
//
//  Created by MAC on 2020/12/28.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SleepValueModel : NSObject

///开始时间
@property (assign, nonatomic) NSInteger start;

///结束时间
@property (assign, nonatomic) NSInteger over;

///对应的睡眠状态
@property (assign, nonatomic) NSInteger status;


@end

NS_ASSUME_NONNULL_END
