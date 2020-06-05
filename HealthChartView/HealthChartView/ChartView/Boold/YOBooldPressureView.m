//
//  YOBooldPressure.m
//  HealthChartView
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "YOBooldPressureView.h"

@interface YOBooldPressureView()

///存放血压视图的数组
@property (strong, nonatomic) NSMutableArray *barArr;

@end


@implementation YOBooldPressureView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        [self configUI];
    }
    return self;
}


-(void)configUI{
    _barArr = [NSMutableArray array];
}



///刷新数据
-(void)reload{
    [self cleanView:_barArr];
    
}



@end
