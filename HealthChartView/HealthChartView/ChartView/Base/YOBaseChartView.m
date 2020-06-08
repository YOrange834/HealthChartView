//
//  YOBaseChartView.m
//  DawnHealth
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 hheTeamiOS. All rights reserved.
//

#import "YOBaseChartView.h"

@interface YOBaseChartView()

///x轴刻度数组
@property (strong, nonatomic) NSMutableArray *xChartLabelsArr;

///Y轴刻度
@property (strong, nonatomic) NSMutableArray *yChartLabelsArr;

///x刻度线
@property (strong, nonatomic) CAShapeLayer * chartXAxisLine;

///y轴刻度线
@property (strong, nonatomic) CAShapeLayer * chartYAxisLine;

///选择的刻度线
@property (strong, nonatomic) UIView *lineView;

@end

@implementation YOBaseChartView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configUI];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}


-(void)configUI{
    self.xChartLabelsArr = [NSMutableArray array];
    self.yChartLabelsArr = [NSMutableArray array];
    _xAxis = [[YOXAxis alloc]init];
    _yAxis = [[YOYAxis alloc]init];
    _model = [[YOChartViewModel alloc]init];
}


#pragma mark - X轴与 Y轴
///画Y轴
-(void)drawYAxis{
    if (self.yAxis.dataArr.count == 0) {
        return;
    }
    float sectionHeight = (self.frame.size.height - self.model.chartMarginTop - self.model.chartMarginBottom);
    
    NSArray *arr = @[@1,@0];
    
    ///0 是均分
    int type = 0;
    if (self.yAxis.rateArr.count != 0) {
        NSAssert(self.yAxis.rateArr.count == self.yAxis.dataArr.count, @"内容数组和刻度数组长度要一致");
    }
    
    
    for(int i = 0; i < self.yAxis.dataArr.count; i++){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.model.chartMarginLeft, self.yAxis.lableHeight)];
        label.font = self.yAxis.lableFont;
        label.textColor = self.yAxis.lableColor;
        [label setTextAlignment:self.yAxis.alignment];
        label.text = self.yAxis.dataArr[i];;
        [self addSubview:label];
        
        if (self.yAxis.rateArr.count > 0) {
            
        }
        
//        label.frame = (CGRect){0, sectionHeight * (1 - a) + _chartMarginTop - kYLabelHeight/2.0, _chartMarginLeft, kYLabelHeight};

        [_yChartLabelsArr addObject:label];
    }
}

///画X轴
-(void)drawXLabel{
    float xLabelWidth = 30;
    int num = 1;
    if (self.xAxis.dataArr.count == 0) {
        return;
    }else if(self.xAxis.dataArr.count == 1){
        xLabelWidth = (self.frame.size.width - self.model.chartMarginLeft - self.model.chartMarginRight);
    }else{
        if (self.xAxis.type == YOXAxisTypeLeftToY) {
            num = 0;
        }
        xLabelWidth = (self.frame.size.width - self.model.chartMarginLeft - self.model.chartMarginRight) / (self.xAxis.dataArr.count - num);
    }
    float yLabel = self.frame.size.height - self.model.chartMarginBottom + self.xAxis.labelToX;
    
    for (int i = 0; i < self.xAxis.dataArr.count; i++) {
        UILabel *lab = [[UILabel alloc]init];
        if (self.xAxis.type == YOXAxisTypeCenterToY) {
            lab.frame = CGRectMake(self.model.chartMarginLeft + i * xLabelWidth - xLabelWidth / 2.0, yLabel, xLabelWidth, self.xAxis.lableHeight);
        }else{
            lab.frame = CGRectMake(self.model.chartMarginLeft + i * xLabelWidth, yLabel, xLabelWidth, self.xAxis.lableHeight);
        }
        
        lab.font = self.xAxis.lableFont;
        lab.textColor = self.xAxis.lableColor;
        lab.textAlignment = self.xAxis.alignment;
        lab.text = self.xAxis.dataArr[i];
        [_xChartLabelsArr addObject:lab];
        [self addSubview:lab];
    }
}

///画X.y轴的线
-(void)drawAxsiLine{
    if(self.xAxis.isShowX){
        _chartXAxisLine = [CAShapeLayer layer];
        _chartXAxisLine.lineCap      = kCALineCapButt;
        _chartXAxisLine.fillColor    = [self.xAxis.xColor CGColor];
        _chartXAxisLine.lineWidth    = self.xAxis.xWidth;
        _chartXAxisLine.strokeEnd    = 0.0;
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        [progressline moveToPoint:CGPointMake(self.model.chartMarginLeft, self.frame.size.height - self.model.chartMarginBottom)];
        [progressline addLineToPoint:CGPointMake(self.frame.size.width - self.model.chartMarginRight,  self.frame.size.height - self.model.chartMarginBottom)];
        [progressline setLineWidth:0.0];
        [progressline setLineCapStyle:kCGLineCapSquare];
        
        _chartXAxisLine.path = progressline.CGPath;
        _chartXAxisLine.strokeColor = [self.xAxis.xColor CGColor];;
        _chartXAxisLine.strokeEnd = 1.0;

        [self.layer addSublayer:_chartXAxisLine];

    }
    
    if (self.yAxis.isShowY) {
        _chartYAxisLine = [CAShapeLayer layer];
        _chartYAxisLine.lineCap      = kCALineCapButt;
        _chartYAxisLine.fillColor    = [self.yAxis.yColor CGColor];
        _chartYAxisLine.lineWidth    = self.yAxis.yWidth;
        _chartYAxisLine.strokeEnd    = 0.0;

        UIBezierPath *progressLeftline = [UIBezierPath bezierPath];

        [progressLeftline moveToPoint:CGPointMake(self.model.chartMarginLeft, self.frame.size.height - self.model.chartMarginBottom)];
        [progressLeftline addLineToPoint:CGPointMake(self.model.chartMarginLeft,  self.model.chartMarginTop)];

        [progressLeftline setLineWidth:1.0];
        [progressLeftline setLineCapStyle:kCGLineCapSquare];
        _chartYAxisLine.path = progressLeftline.CGPath;
        _chartYAxisLine.strokeColor = [self.yAxis.yColor CGColor];
        _chartYAxisLine.strokeEnd = 1.0;

        [self.layer addSublayer:_chartYAxisLine];
    }
    
    
}


-(void)refreshXY{
    [self.chartXAxisLine removeFromSuperlayer];
    [self.chartYAxisLine removeFromSuperlayer];
    [self cleanView:_xChartLabelsArr];
    
    [self drawXLabel];
    [self drawAxsiLine];
}


///清除所有视图
-(void)cleanView:(NSMutableArray *)arr{
    if (arr.count > 0) {
        [arr makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [arr removeAllObjects];
    }
}


#pragma mark - 滑动选择相关的视图

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, self.frame.size.height - self.model.chartMarginBottom)];
        _lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_lineView];
        _lineView.hidden = YES;
    }
    return _lineView;
}


@end
