//
//  SleepChartView.h
//  HealthChartView
//
//  Created by MAC on 2020/12/28.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YOBaseChartView.h"

NS_ASSUME_NONNULL_BEGIN

@class SleepInfoModel;
@class SleepChartView;
@class SleepValueModel;
@protocol YOSleepDelegate <NSObject>

@optional

-(void)yoSleepView:(SleepChartView *)chartView sleepInfo:(SleepInfoModel *)infoModel valueModel:(SleepValueModel *)valueModel detailView:(UIView *)detailView;

@end

@interface SleepChartView : YOBaseChartView


@property (strong, nonatomic) NSMutableArray <SleepInfoModel *> *modelArr;

///清洗数据，数据格式为@[@(1),@(1),@(2),@(3)]; NSNumber或者NSString类型都可以
@property (strong, nonatomic) NSArray *dataArr;

@property (weak, nonatomic) id<YOSleepDelegate> sleepDelegate;


///刷新数据，调用次方法前，必须先清洗数据
-(void)reloadData;

@end

NS_ASSUME_NONNULL_END
