//
//  SleepLineView.h
//  HealthChartView
//
//  Created by MAC on 2020/12/28.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SleepInfoModel;
@class SleepValueModel;

@interface SleepLineView : UIView


@property (strong, nonatomic) NSMutableArray <SleepInfoModel *> *modelArr;

///刷新数据
-(void)reloadData:(NSMutableArray <SleepValueModel *>*)data;

@end

NS_ASSUME_NONNULL_END
