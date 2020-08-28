//
//  ECGShareView.m
//  BeyondHealth
//
//  Created by hrrMac on 2020/8/13.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "ECGShareView.h"
#import "ECGGridView.h"

@interface ECGShareView()

@property (nonatomic , assign) CGPoint *points;
@property (nonatomic , assign) NSInteger currentPointsCount;

@property (strong, nonatomic) UIBezierPath *path;

@property (strong, nonatomic) CAShapeLayer *lineLayer;

@property (assign, nonatomic) CGPoint beforePoint;


@end


@implementation ECGShareView{
    float _pointX;
    float _pointY;
    
    float _oneGrid;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        self.clipsToBounds = YES;
    }
    return self;
}



-(void)configUI{
    
    float oneGrid = (1240 - 40 * 2 - 45 * 2.0) / (15 * 5 * 5.0);
    _oneGrid = oneGrid;
    
    float height = oneGrid * 10 * 5;
    
    ECGGridView *grid = [[ECGGridView alloc]initWithFrame:CGRectMake(0, 0, 1240 - 40 * 2 - 45 * 2, height)];
    grid.line = self.line;
    [grid drawGridBackgroundView];
    [self addSubview:grid];
    
    
    
    _path = [UIBezierPath bezierPath];
    
}


-(void)drawMap:(NSArray *)arr{
    if (arr.count == 0) {
        return;
    }
    
    float one = _oneGrid / 10.0;
    float y = _oneGrid * 10 * 4 / 2.0;

    UIBezierPath *path = [UIBezierPath bezierPath];
    {
        float ypoint = [arr.firstObject intValue] / 1000.0 / 0.1 * one;
        [path moveToPoint:CGPointMake(0 , y - ypoint)];
    }

    for (int i = 0; i < arr.count; i++) {
        float ypoint = [arr[i] intValue] / 1000.0 / 0.1 * one;
        CGPoint point = CGPointMake(i * one , y - ypoint);
        [path addLineToPoint:point];
    }

   
    CAShapeLayer *chartLevelLine = [CAShapeLayer layer];
    chartLevelLine.lineCap      = kCALineCapRound;
    chartLevelLine.fillColor    = nil;//[[UIColor redColor] CGColor];
    chartLevelLine.lineWidth    = 1;
    chartLevelLine.strokeEnd    = 0.0;
    chartLevelLine.path = path.CGPath;
    chartLevelLine.lineJoin = kCALineJoinRound;

    chartLevelLine.strokeColor = [[UIColor redColor] CGColor] ;
          
    chartLevelLine.strokeEnd = 1.0;

    [self.layer addSublayer:chartLevelLine];
    _lineLayer = chartLevelLine;
}


///清楚数据
-(void)clearData{
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(0, 257 / 2.0)];
    _beforePoint = CGPointMake(0, 257 / 2.0);
    _lineLayer.path = _path.CGPath;
}




@end
