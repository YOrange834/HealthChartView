//
//  ECGChartView.m
//  HealthChartView
//
//  Created by hrrMac on 2020/6/18.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "ECGChartView.h"

@interface ECGChartView()

@property (strong, nonatomic) UIView *gridView;

@property (strong, nonatomic) UIView *ecgView;


///大网格视图
@property (strong, nonatomic) CAShapeLayer *bigGridLayer;


///小网格视图
@property (strong, nonatomic) CAShapeLayer *smallGridLayer;

///前一个点
@property (assign, nonatomic) CGPoint beforePoint;

///实时心电运动的路径
@property (strong, nonatomic) UIBezierPath *linePath;

///对应实时心电运动的视图
@property (strong, nonatomic) CAShapeLayer *lineLayer;



///时间刻度
@property (assign, nonatomic) CGFloat pointX;

///电压系数
@property (assign, nonatomic) CGFloat pointY;

///心电图贝塞尔路径
@property (strong, nonatomic) NSMutableArray <UIBezierPath *> *pathArr;

///两条心电轨迹的时候需要用到，是否开始减少
@property (assign, nonatomic) BOOL isStartReduce;

@end


@implementation ECGChartView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        [self initConfig];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        [self initConfig];
    }
    return self;
}


-(void)initConfig{
    self.gridView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:self.gridView];
    
    self.ecgView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:self.ecgView];
    
    self.clipsToBounds = YES;
    self.oneGridPoint = CGPointMake(257 / 14.0 / 5, 257 / 14.0 /5);
    self.bigGridColor = [UIColor colorWithRed:0x99 / 255.0 green:0x99 / 255.0 blue:0x99 / 255.0 alpha:1];
    self.smallGridColor = [UIColor colorWithRed:0xEE / 255.0 green:0xEE / 255.0 blue:0xEE / 255.0 alpha:0.4];
    _coefficientX = 10.0;
    _coefficientY = 500.0;
    _JumpType = ECGChartTypeTWOLineJump;
    _isShowGrid = YES;
}


///刷新配置信息
-(void)reloadConfig{
    _pointY = self.oneGridPoint.y / _coefficientY;
    _pointX = self.oneGridPoint.x / _coefficientX;
    
    _linePath = [UIBezierPath bezierPath];
    [_linePath moveToPoint:CGPointMake(0, self.frame.size.height / 2.0)];
    _beforePoint = CGPointMake(0, self.frame.size.height / 2.0);
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineCap       = kCALineCapButt;
    lineLayer.fillColor     = [[UIColor clearColor] CGColor];
    lineLayer.lineWidth     = 2;
    lineLayer.path          = _linePath.CGPath;
    lineLayer.lineJoin      = kCALineJoinRound; //拐点处理

    lineLayer.strokeColor = [[UIColor redColor] CGColor] ;
    lineLayer.strokeEnd = 1.0;

//    [self.layer addSublayer:chartLevelLine];
    [self.ecgView.layer addSublayer:lineLayer];
    _lineLayer = lineLayer;
    
}


/**
1 大格是0.2s 一大格中有5个小格子    5大格是一秒
1 大格是0.5mv 一大格中5个小格子     一小格子 0.1mV
100毫秒取25个点  0.1s 取25个点  0.2s 取50个点。  一个大格字要放50个点 ，一个小格子要放10个点
 
*/
-(void)drawMap:(NSArray *)arr{
    if (self.JumpType == ECGChartTypeTWOLineJump) {
        [self drawTwoLinwMap:arr];
    }else{
        [self drawOneLinwMap:arr];
    }
    
}


-(void)drawTwoLinwMap:(NSArray *)arr{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_beforePoint];
    if (_beforePoint.x + self.oneGridPoint.x * 5 * 2 > self.frame.size.width) { //大于两个点
        _isStartReduce = YES;
        
        for (int i = 0; i < arr.count; i++) {
            if (_beforePoint.x >= self.frame.size.width){

                CGPoint point = CGPointMake(0, self.frame.size.height / 2.0 - _pointY * [arr[i] intValue]);
                [path moveToPoint:point];
                _beforePoint = point;
                
            }else{
                CGPoint point = CGPointMake(_beforePoint.x + _pointX , self.frame.size.height / 2.0 - _pointY * [arr[i] intValue]);
                [path addLineToPoint:point];
                _beforePoint = point;
            }
                        
        }

    }else{
        for (int i = 1; i < arr.count; i++) {
            CGPoint point = CGPointMake(_beforePoint.x + _pointX , self.frame.size.height / 2.0 - _pointY * [arr[i] intValue]);
            [path addLineToPoint:point];
            _beforePoint = point;
        }
    }
    [self.pathArr addObject:path];

    
    if (_isStartReduce) {
        [self.pathArr removeObjectAtIndex:0];
    }
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    for (int i = 0; i < self.pathArr.count; i++) {
        [linePath appendPath:self.pathArr[i]];
    }
    _lineLayer.path = linePath.CGPath;
}


-(void)drawOneLinwMap:(NSArray *)arr{
    for (int i = 0; i < arr.count; i++) {
        if (_beforePoint.x >= self.frame.size.width) {
            _linePath = [UIBezierPath bezierPath];
            _beforePoint = CGPointMake(0 , self.frame.size.height / 2.0 - _pointY * [arr[i] intValue]);
            [_linePath moveToPoint:_beforePoint];
            continue;
        }
        [self calculateOnePoint:[arr[i] intValue]];
        
    }
    _lineLayer.path = _linePath.CGPath;
}


-(void)calculateOnePoint:(int)Value{
    //一大格横线达标 500
    CGPoint point = CGPointMake(_beforePoint.x + _pointX , self.frame.size.height / 2.0 - _pointY * Value);
    
    [_linePath addLineToPoint:point];
    _beforePoint = point;
    return;
//
//
//    CGPoint midPoint = [ECGChartView midPointBetweenPoint1:_beforePoint andPoint2:point];
//    [_linePath addQuadCurveToPoint:midPoint controlPoint:[ECGChartView midPointBetweenPoint1:midPoint andPoint2:_beforePoint]];
//    [_linePath addQuadCurveToPoint:point controlPoint:[ECGChartView midPointBetweenPoint1:midPoint andPoint2:point]];
//    _beforePoint = point;
}

//+ (CGPoint)midPointBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
//    return CGPointMake((point1.x + point2.x) / 2, (point1.y + point2.y) / 2);
//}



///刷新网格视图
-(void)reloadGrid{
    if (_smallGridLayer) {
        [_smallGridLayer removeFromSuperlayer];
    }
    if (_bigGridLayer) {
        [_bigGridLayer removeFromSuperlayer];
    }
    
    if(!_isShowGrid){
        return;
    }
    
    UIBezierPath *smallline = [UIBezierPath bezierPath];
    UIBezierPath *bigline = [UIBezierPath bezierPath];

    float halfHeight = self.frame.size.height / 2.0;
    
    ///横线
    int i = 0;
    while (halfHeight > self.oneGridPoint.y * i) {
        
        if (i % 5 == 0) {
            [bigline moveToPoint:CGPointMake(0, halfHeight - self.oneGridPoint.y * i)];
            [bigline addLineToPoint:CGPointMake(self.frame.size.width ,halfHeight - self.oneGridPoint.y * i)];
            
            if (i != 0) {
                [bigline moveToPoint:CGPointMake(0, halfHeight + self.oneGridPoint.y * i)];
                [bigline addLineToPoint:CGPointMake(self.frame.size.width ,halfHeight + self.oneGridPoint.y * i)];
            }
            
        }else{
            [smallline moveToPoint:CGPointMake(0, halfHeight - self.oneGridPoint.y * i)];
            [smallline addLineToPoint:CGPointMake(self.frame.size.width ,halfHeight - self.oneGridPoint.y * i)];
            
            [smallline moveToPoint:CGPointMake(0, halfHeight + self.oneGridPoint.y * i)];
            [smallline addLineToPoint:CGPointMake(self.frame.size.width ,halfHeight + self.oneGridPoint.y * i)];
        }
        i++;
    }
    ///竖线
    i = 0;
    while (self.frame.size.width > self.oneGridPoint.x * i) {
        if (i % 5 == 0) {
            [bigline moveToPoint:CGPointMake(self.oneGridPoint.x * i , 0)];
            [bigline addLineToPoint:CGPointMake(self.oneGridPoint.x * i, self.frame.size.height)];
            
        }else{
            [smallline moveToPoint:CGPointMake(self.oneGridPoint.x * i , 0)];
            [smallline addLineToPoint:CGPointMake(self.oneGridPoint.x * i , self.frame.size.height)];
        }
        i++;
    }

    [smallline setLineWidth:0.0];
    [smallline setLineCapStyle:kCGLineCapSquare];
    
    [bigline setLineWidth:0.0];
    [bigline setLineCapStyle:kCGLineCapSquare];
    
    {
        CAShapeLayer *chartLevelLine = [CAShapeLayer layer];
        chartLevelLine.lineCap      = kCALineCapButt;
        chartLevelLine.fillColor    = [UIColor redColor].CGColor; //[self.smallGridColor CGColor];
        chartLevelLine.lineWidth    = 0.5;
        chartLevelLine.strokeEnd    = 0.0;
        chartLevelLine.path = smallline.CGPath;
        chartLevelLine.strokeEnd = 1.0;
        chartLevelLine.strokeColor = [self.smallGridColor CGColor];
        _smallGridLayer = chartLevelLine;
    }
    {
        CAShapeLayer *chartLevelLine = [CAShapeLayer layer];
        chartLevelLine.lineCap      = kCALineCapButt;
        chartLevelLine.fillColor    = [self.bigGridColor CGColor];
        chartLevelLine.lineWidth    = 0.5;
        chartLevelLine.strokeEnd    = 0.0;
        chartLevelLine.path = bigline.CGPath;
        chartLevelLine.strokeEnd = 1.0;
        chartLevelLine.strokeColor = [self.bigGridColor CGColor];
        _bigGridLayer = chartLevelLine;
    }
//    [self.layer addSublayer:_smallGridLayer];
//    [self.layer addSublayer:_bigGridLayer];
    [self.gridView.layer addSublayer:_smallGridLayer];
    [self.gridView.layer addSublayer:_bigGridLayer];
}



///清楚数据
-(void)clearData{
//    [_lineLayer removeFromSuperlayer];
    _beforePoint = CGPointMake(0, self.frame.size.height / 2.0);
    if (self.JumpType == ECGChartTypeOneLineJump) {
        _linePath = [UIBezierPath bezierPath];
        [_linePath moveToPoint:CGPointMake(0, self.frame.size.height / 2.0)];
        _lineLayer.path = _linePath.CGPath;
    }else{
        _isStartReduce = NO;
        [self.pathArr removeAllObjects];
    }
    
}



-(NSMutableArray<UIBezierPath *> *)pathArr{
    if (!_pathArr) {
        _pathArr = [NSMutableArray array];
    }
    return _pathArr;
}


@end
