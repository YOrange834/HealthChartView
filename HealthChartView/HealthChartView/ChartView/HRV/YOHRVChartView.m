//
//  YOHRVChartView.m
//  HealthChartView
//
//  Created by HOrange on 2021/8/7.
//  Copyright © 2021 HOrange. All rights reserved.
//

#import "YOHRVChartView.h"
#import "YOHRVBarView.h"

@interface YOHRVChartView()

///存放视图的数组
@property (strong, nonatomic) NSMutableArray *barArr;

@end


@implementation YOHRVChartView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initConfigUI];
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        [self initConfigUI];
    }
    return self;
}


-(void)initConfigUI{
    _barArr = [NSMutableArray array];
//    _number = 1;
//    _isNeedShowRange = YES;
    self.viewClass = [YOHRVBarView class];
//    _systoleColor = [UIColor colorWithRed:99/255.0 green:222/255.0 blue:195/255.0 alpha:1.0];
//    _diastolicColor = [UIColor colorWithRed:62/255.0 green:215/255.0 blue:182/255.0 alpha:1.0];
//    self.yAxis.dataArr = @[@"30",@"180"];

}



///刷新数据
-(void)reload{
//    NSAssert(self.canSilder && self.detailView, @"能滑动的情况下，需要要有详情视图");
    self.userInteractionEnabled = self.canSilder; //是否响应滑动事件
    
    ///清除视图
    [self cleanView:_barArr];
    
    
    [self refreshXY];
    [self refreshBarView];
    
    [self silderViewConfiger];
}


///刷新血压视图
-(void)refreshBarView{
    CGFloat chartHeight = self.frame.size.height - self.model.chartMarginTop - self.model.chartMarginBottom;
    
    // 展示7个小时的 没2分钟一根
    CGFloat oneBarWidth = (self.frame.size.width - self.model.chartMarginLeft - self.model.chartMarginRight) / 21;
    for (int i = 0; i < self.dataArr.count; i++) {
        YOHRVBarView *bar = [[YOHRVBarView alloc]initWithFrame:CGRectMake(i * oneBarWidth + self.model.chartMarginLeft, self.model.chartMarginTop, oneBarWidth, chartHeight)];
        bar.tag = i + 100;
        [bar createCircle:self.dataArr[i]];
        [_barArr addObject:bar];
        [self addSubview:bar];
    }

}


@end
