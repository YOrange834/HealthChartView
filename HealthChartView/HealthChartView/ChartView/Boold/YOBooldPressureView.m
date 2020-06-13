//
//  YOBooldPressure.m
//  HealthChartView
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "YOBooldPressureView.h"
#import "YOBooldPressureBarView.h"

@interface YOBooldPressureView()

///存放血压视图的数组
@property (strong, nonatomic) NSMutableArray *barArr;

@property (strong, nonatomic) CALayer *lowLayer;

@property (strong, nonatomic) CALayer *highLayer;

@end


@implementation YOBooldPressureView

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
    _number = 1;
    _isNeedShowRange = YES;
    self.viewClass = [YOBooldPressureBarView class];
    _systoleColor = [UIColor colorWithRed:99/255.0 green:222/255.0 blue:195/255.0 alpha:1.0];
    _diastolicColor = [UIColor colorWithRed:62/255.0 green:215/255.0 blue:182/255.0 alpha:1.0];
    self.yAxis.dataArr = @[@"30",@"180"];

}



///刷新数据
-(void)reload{
//    NSAssert(self.canSilder && self.detailView, @"能滑动的情况下，需要要有详情视图");
    self.userInteractionEnabled = self.canSilder; //是否响应滑动事件
    
    ///清除视图
    [self cleanView:_barArr];
    if (self.lowLayer) {
        [self.lowLayer removeFromSuperlayer];
    }
    if (self.highLayer) {
        [self.highLayer removeFromSuperlayer];
    }
    
    ///显示高低压范围
    if (_isNeedShowRange) {
        [self createLowBgView];
        [self creaeteHeightBgView];
    }
    
    [self refreshXY];
    [self refreshBarView];
    
    [self silderViewConfiger];
}


///刷新血压视图
-(void)refreshBarView{
    CGFloat chartHeight = self.frame.size.height - self.model.chartMarginTop - self.model.chartMarginBottom;
    CGFloat oneBarWidth = (self.frame.size.width - self.model.chartMarginLeft - self.model.chartMarginRight) / _number;
    for (int i = 0; i < self.dataArr.count; i++) {
        YOBooldPressureBarView *bar = [[YOBooldPressureBarView alloc]initWithFrame:CGRectMake(i * oneBarWidth + self.model.chartMarginLeft, self.model.chartMarginTop, oneBarWidth, chartHeight)];
        bar.tag = i + 100;
        [bar drawBar:self.dataArr[i].Height low:self.dataArr[i].low];
        [_barArr addObject:bar];
        [self addSubview:bar];
    }

}


-(void)createLowBgView{
    float onePoint = (self.frame.size.height - self.model.chartMarginBottom - self.model.chartMarginTop  ) / ([self.yAxis.dataArr.lastObject floatValue] - [self.yAxis.dataArr.firstObject floatValue]);

    float width = (90 - 60) * onePoint;
        
    CAShapeLayer *chartLevelLine = [CAShapeLayer layer];
    chartLevelLine.lineCap      = kCALineCapButt;
    chartLevelLine.fillColor    = [self.systoleColor CGColor];
    chartLevelLine.lineWidth    = width;
    chartLevelLine.strokeEnd    = 0.0;

    UIBezierPath *progressline = [UIBezierPath bezierPath];

    CGFloat y = ([self.yAxis.dataArr.lastObject floatValue] - (60 + 90) / 2) * onePoint + self.model.chartMarginTop;
    
    [progressline moveToPoint:CGPointMake(self.model.chartMarginLeft, y)];
    [progressline addLineToPoint:CGPointMake(self.frame.size.width - self.model.chartMarginRight,y)];

    [progressline setLineWidth:0.0];
    [progressline setLineCapStyle:kCGLineCapSquare];
    chartLevelLine.path = progressline.CGPath;

    chartLevelLine.strokeColor = [self.systoleColor CGColor];
    chartLevelLine.strokeEnd = 1.0;
    
    _lowLayer = chartLevelLine;
    [self.layer addSublayer:chartLevelLine];
}


-(void)creaeteHeightBgView{
    float onePoint = (self.frame.size.height - self.model.chartMarginBottom - self.model.chartMarginTop  ) / ([self.yAxis.dataArr.lastObject floatValue] - [self.yAxis.dataArr.firstObject floatValue]);
        
    float width = (140 - 90) * onePoint;

    CAShapeLayer *chartLevelLine = [CAShapeLayer layer];
    chartLevelLine.lineCap      = kCALineCapButt;
    chartLevelLine.fillColor    = [self.diastolicColor CGColor];
    chartLevelLine.lineWidth    = width;
    chartLevelLine.strokeEnd    = 0.0;

    UIBezierPath *progressline = [UIBezierPath bezierPath];

    CGFloat y = ([self.yAxis.dataArr.lastObject floatValue] - (140 + 90) / 2) * onePoint + self.model.chartMarginTop;

    [progressline moveToPoint:CGPointMake(self.model.chartMarginLeft, y)];
    [progressline addLineToPoint:CGPointMake(self.frame.size.width - self.model.chartMarginRight, y)];

    [progressline setLineWidth:0.0];
    [progressline setLineCapStyle:kCGLineCapSquare];
    chartLevelLine.path = progressline.CGPath;

    chartLevelLine.strokeColor = [self.diastolicColor CGColor];
      
//    [self addSeparatorAnimationIfNeeded];
    chartLevelLine.strokeEnd = 1.0;
    
    _highLayer = chartLevelLine;
    [self.layer addSublayer:chartLevelLine];
    
    
}

@end
