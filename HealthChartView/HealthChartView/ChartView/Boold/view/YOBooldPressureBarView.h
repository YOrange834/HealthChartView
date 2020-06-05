//
//  YOBooldPressureBarView.h
//  HealthChartView
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YOBooldPressureBarView : UIView

///柱体的宽度，默认为width的 3/4
@property (assign, nonatomic) CGFloat pillarWidth;

///高压的颜色
@property (strong, nonatomic) UIColor *HeightColor;

///高压的颜色
@property (strong, nonatomic) UIColor *lowColor;

///渐变色的颜色
@property (strong, nonatomic) NSArray *colorArr;

///最高刻度线 默认180
@property (assign, nonatomic) CGFloat maxScale;

///最低刻度线 ，默认30
@property (assign, nonatomic) CGFloat minScale;

///最高，最低血压的，圆角大小 ，默认2
@property (assign, nonatomic) CGFloat radius;

-(void)drawBar:(NSInteger)heigh low:(NSInteger)low;


@end

NS_ASSUME_NONNULL_END
