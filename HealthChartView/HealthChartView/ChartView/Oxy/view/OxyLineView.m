//
//  OxyLineView.m
//  HealthChartView
//
//  Created by MAC on 2020/12/26.
//  Copyright © 2020 HOrange. All rights reserved.
//


#import "OxyLineView.h"

@interface OxyLineView()

@property (nonatomic , assign) CGPoint *points;
@property (nonatomic , assign) NSInteger currentPointsCount;

@property (strong, nonatomic) UIBezierPath *path;

@property (strong, nonatomic) CAShapeLayer *lineLayer;

@property (assign, nonatomic) CGPoint beforePoint;

@end


@implementation OxyLineView{
    float _oneWidth;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
    }
    return self;
}



-(void)configUI{
    _oneWidth = self.frame.size.width / (7 * 6); //半个小时
    if (_themeColor == nil) {
        _themeColor = [UIColor colorWithRed: 33 / 255.0 green:197 / 255.0 blue:173 / 255.0 alpha:1];
    }
    if(_lineColor == nil){
        _lineColor = [UIColor colorWithRed:255 / 255.0 green:113 / 255.0 blue:24 / 255.0 alpha:1];
    }
    if(_gradientArrColor == nil){
        _gradientArrColor = @[
            [UIColor colorWithRed:255 / 255.0 green:113 / 255.0 blue:24 / 255.0 alpha:1],
            [UIColor colorWithRed:255 / 255.0 green:167 / 255.0 blue:131 / 255.0 alpha:1]
        ];
    }
    if(_ApneaColor == nil){
        _ApneaColor = [UIColor colorWithRed:255 / 255.0 green:70 / 255.0 blue:24 / 255.0 alpha:1];

    }
}

-(void)drawOxyView{
    
    NSArray *arr = self.oxyArr;
    if(arr == nil || arr.count == 0){
        return;
    }
    [self configUI];
    
    NSMutableArray *pusePointArr = [NSMutableArray array];
    
    UIBezierPath *currentProgressLine = [UIBezierPath bezierPath];
    currentProgressLine.lineCapStyle = kCGLineCapRound; //线条拐角
    currentProgressLine.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    CGPoint last;
    CGPoint First;

    ///先把无效的点过滤掉
    NSMutableArray *pointArr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {

        int one = [arr[i] intValue];
        if (one > 100 || one < 70) {
            continue;
        }
        
        float y;
        if (one > 90) {  //这个是占三分之二
            y = (100 - one) / 10.0 * self.frame.size.height * 2 / 3.0;
        }else{
            y = self.frame.size.height * 2 / 3 +  self.frame.size.height / 3 / 20 * (90 - one);
        }
        CGPoint point = CGPointMake(i * _oneWidth,y );
        [pointArr addObject:NSStringFromCGPoint(point)];
        
        int puse = [self.puseArr[i] intValue];
        if (puse == 1) {
            [pusePointArr addObject:NSStringFromCGPoint(point)];
        }
        
    }

    for (int i = 0; i < pointArr.count - 1; i++) {
        CGPoint point = CGPointFromString(pointArr[i]);
        CGPoint point2 = CGPointFromString(pointArr[i + 1]);

        if (i == 0) {
            First = point;
            [currentProgressLine moveToPoint:point];
        }else if (i == pointArr.count - 1 - 1){
            last = point2;
        }
        CGPoint midPoint = [OxyLineView midPointBetweenPoint1:point andPoint2:point2];
        [currentProgressLine addQuadCurveToPoint:midPoint controlPoint:[OxyLineView controlPointBetweenPoint1:midPoint andPoint2:point]];
        [currentProgressLine addQuadCurveToPoint:point2 controlPoint:[OxyLineView controlPointBetweenPoint1:midPoint andPoint2:point2]];
    }

    last.x += _oneWidth;
    [currentProgressLine addLineToPoint:CGPointMake(last.x, last.y)];
    
    CAShapeLayer *chartLine = [CAShapeLayer layer];
    chartLine.fillColor = [UIColor clearColor].CGColor;
    chartLine.lineWidth = 3.0;
    chartLine.path = currentProgressLine.CGPath;
    chartLine.strokeColor = _lineColor.CGColor;
               
    [self.layer addSublayer:chartLine];
    
    
    //画渐变
    {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.startPoint = CGPointMake(0.0,0.0);
        gradientLayer.endPoint = CGPointMake(0.0 ,1.0);
        gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        gradientLayer.colors = @[(__bridge id)_gradientArrColor.firstObject.CGColor,(__bridge id)_gradientArrColor.lastObject.CGColor];
        gradientLayer.locations = @[@0.6, @1.0];

        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        
        [currentProgressLine addLineToPoint:CGPointMake(last.x, self.frame.size.height)];
        [currentProgressLine addLineToPoint:CGPointMake(First.x, self.frame.size.height)];
        [currentProgressLine closePath];
        
        maskLayer.path = currentProgressLine.CGPath;
        gradientLayer.mask = maskLayer;
        [self.layer addSublayer:gradientLayer];
    }
    
    [self puseView:pusePointArr];

    

   
}


///呼吸暂停的圆圈
-(void)puseView:(NSMutableArray *)pusePointArr{
    for (NSString *str in pusePointArr) {
        CGPoint point = CGPointFromString(str);
        point.y -= 1;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:3 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        path.lineWidth = 0.0;
        path.lineCapStyle = kCGLineCapRound;
        path.lineJoinStyle = kCGLineJoinRound;
        
        CAShapeLayer *chartLine = [CAShapeLayer layer];
        chartLine.fillColor = _ApneaColor.CGColor;
        chartLine.lineWidth = 0.0;
        chartLine.path = path.CGPath;
        chartLine.strokeColor = UIColor.clearColor.CGColor;
        [self.layer addSublayer:chartLine];
        
    }
    
}


+ (CGPoint)controlPointBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
    CGPoint controlPoint = [self midPointBetweenPoint1:point1 andPoint2:point2];
    CGFloat diffY = abs((int) (point2.y - controlPoint.y));
    if (point1.y < point2.y)
        controlPoint.y += diffY;
    else if (point1.y > point2.y)
        controlPoint.y -= diffY;
    return controlPoint;
}

+ (CGPoint)midPointBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
    return CGPointMake((point1.x + point2.x) / 2.0, (point1.y + point2.y) / 2.0);
}



@end
