//
//  YOHRVBarView.h
//  HealthChartView
//
//  Created by HOrange on 2021/8/7.
//  Copyright © 2021 HOrange. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YOHRVBarView : UIView

/// 圆点填充的颜色，默认为红色
@property (nonatomic) UIColor *circleStoreColor;


-(void)createCircle:(NSArray *)data;
@end

NS_ASSUME_NONNULL_END
