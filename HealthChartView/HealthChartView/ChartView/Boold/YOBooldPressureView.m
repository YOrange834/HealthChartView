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
}



///刷新数据
-(void)reload{
    [self cleanView:_barArr];
    [self refreshXY];
    [self refreshBarView];
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



#pragma mark - touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
}


@end
