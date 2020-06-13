//
//  YOBaseChartView.h
//  DawnHealth
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 hheTeamiOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YOXAxis.h"
#import "YOYAxis.h"

#import "YOChartViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class YOBaseChartView;

@protocol YOBaseChartViewDelegate <NSObject>

@optional

///当前滑动选择的位置
-(void)yoBaseChartView:(YOBaseChartView *)chartView selectIndex:(NSInteger)index detailView:(UIView *)detailView;

///是否在滑动或者查看的回调
-(void)yoBaseChartView:(YOBaseChartView *)chartView isSilder:(BOOL)isSilder;

@end


@interface YOBaseChartView : UIView

///X轴相关参数设置
@property (strong, nonatomic) YOXAxis *xAxis;

///X轴相关参数设置
@property (strong, nonatomic) YOYAxis *yAxis;

///界面相关间距等设置
@property (strong, nonatomic) YOChartViewModel *model;


///画X轴的刻度
-(void)drawXLabel;

///画XY轴两条线
-(void)drawAxsiLine;

///清除视图
-(void)cleanView:(NSMutableArray *)arr;

///先清除后添加
-(void)refreshXY;


//---------------------------- 滑动视图相关


///是否能滑动展示详细参数,默认为NO
@property (assign, nonatomic) BOOL canSilder;

///选择的刻度线
@property (strong, nonatomic) UIView *lineView;


///刻度线的层级，默认最上层
@property (assign, nonatomic) BOOL isTop;

///传入视图的类型，内部使用(如果展示滑动，viewClass)
@property (strong, nonatomic) Class viewClass;

@property (weak, nonatomic) id<YOBaseChartViewDelegate> delegate;

///默认YES 详细参数视图的移动方式，是否跟随柱体中间移动，NO为跟随手势移动
@property (assign, nonatomic) BOOL moveFollowCenter;

///滑动视图的层级配置
-(void)silderViewConfiger;

///配置详情视图
-(void)detailViewConfiger:(UIView *)detailView;

@end

NS_ASSUME_NONNULL_END
