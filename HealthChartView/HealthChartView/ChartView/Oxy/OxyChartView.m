//
//  OxyChartView.m
//  HealthChartView
//
//  Created by MAC on 2020/12/26.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "OxyChartView.h"
#import "OxyLineView.h"
@interface OxyChartView()

///存放血氧图的数组
@property (strong, nonatomic) NSMutableArray *barArr;

@end

@implementation OxyChartView

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
    self.viewClass = [OxyChartView class];
}

///刷新数据
-(void)reload{
//    NSAssert(self.canSilder && self.detailView, @"能滑动的情况下，需要要有详情视图");
    self.userInteractionEnabled = self.canSilder; //是否响应滑动事件
    
    ///清除视图
    [self cleanView:_barArr];
    
    [self refreshXY];
    [self refreshBarView];
    
    self.moveFollowCenter = NO;
    
    [self silderViewConfiger];
}


///刷新血压视图
-(void)refreshBarView{
    CGFloat chartHeight = self.frame.size.height - self.model.chartMarginTop - self.model.chartMarginBottom;
    CGFloat chartWight = self.frame.size.width - self.model.chartMarginLeft - self.model.chartMarginRight;
    if (self.dataArr.count > 0) {
        
        OxyLineView *line = [[OxyLineView alloc]initWithFrame:CGRectMake(self.model.chartMarginLeft, self.model.chartMarginTop, chartWight, chartHeight)];
        line.oxyArr = self.dataArr;
        line.puseArr = self.puseArr;
        line.clipsToBounds = YES;
        line.userInteractionEnabled = NO;
        [line drawOxyView];
        [self addSubview:line];
    }

}


@end
