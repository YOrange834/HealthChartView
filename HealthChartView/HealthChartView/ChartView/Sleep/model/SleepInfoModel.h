//
//  SleepInfoModel.h
//  HealthChartView
//
//  Created by MAC on 2020/12/28.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SleepInfoModel : NSObject

///状态 深睡，浅睡，快速眼动之类的
@property (assign, nonatomic) NSInteger status;

///睡眠的详情解释
@property (strong, nonatomic) NSString *detail;

///线条的颜色
@property (strong, nonatomic) UIColor *color;

///高度的位置,与顶部对齐为0.0
@property (assign, nonatomic) CGFloat top;

///低度的位置,与底部对齐为1.0
@property (assign, nonatomic) CGFloat bottom;

@end

NS_ASSUME_NONNULL_END
