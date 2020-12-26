//
//  OxyLineView.h
//  HealthChartView
//
//  Created by MAC on 2020/12/26.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OxyLineView : UIView

///血氧的点数据
@property (strong, nonatomic) NSArray *oxyArr;

///呼吸暂停的点
@property (strong, nonatomic) NSArray *puseArr;

///背景色
@property (strong, nonatomic) UIColor *themeColor;

///血氧线条的颜色
@property (strong, nonatomic) UIColor *lineColor;

///渐变色
@property (strong, nonatomic) NSArray <UIColor *> *gradientArrColor;

///呼吸暂停的颜色
@property (strong, nonatomic) UIColor *ApneaColor;

///绘制血氧图
-(void)drawOxyView;


-(void)clearData;

@end

NS_ASSUME_NONNULL_END
