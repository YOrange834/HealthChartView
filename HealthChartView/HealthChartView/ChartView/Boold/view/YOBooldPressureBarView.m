//
//  YOBooldPressureBarView.m
//  HealthChartView
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "YOBooldPressureBarView.h"

@interface YOBooldPressureBarView()

@property (strong, nonatomic) CAShapeLayer *headleLine;

@property (strong,nonatomic) CAShapeLayer *chartLine;

@property (strong, nonatomic) CAShapeLayer *bottomLine;

@end

@implementation YOBooldPressureBarView{
    CGFloat _lineWidth;
    ///一个单位刻度的高度 (用实际高度 / 刻度的差值)
    CGFloat _oneUnit;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}


-(void)configUI{
    _chartLine = [self configLayer];
    _headleLine = [self configLayer];
    _bottomLine = [self configLayer];
    self.clipsToBounds = YES;
    
    _lineWidth = self.frame.size.width;
    _pillarWidth = _lineWidth / 4.0 * 3.0;
    _pillarHeight = 7.0;
    
    _HeightColor = [UIColor colorWithRed:251/255.0 green:130/255.0 blue:79/255.0 alpha:1.0];
    _lowColor = [UIColor colorWithRed:250/255.0 green:206/255.0 blue:48/255.0 alpha:1.0];
    _colorArr = @[[UIColor colorWithRed:255/255.0 green:167/255.0 blue:131/255.0 alpha:1.0],
                  [UIColor colorWithRed:220/255.0 green:162/255.0 blue:129/255.0 alpha:0.69]];
    _maxScale = 180;
    _minScale = 30;
    _oneUnit = self.frame.size.height / (180.0 - 30.0);
    
    _radius = 2;
    
}


-(CAShapeLayer *)configLayer{
    CAShapeLayer *chartLine= [CAShapeLayer layer];
    chartLine.lineCap      = kCALineCapButt;
    chartLine.strokeStart    = 0.0;
    [self.layer addSublayer:chartLine];
    return chartLine;
}



#pragma mark - start draw

-(void)drawBar:(NSInteger)heigh low:(NSInteger)low{
    ///血压一般不会超过180
    if(low > 180 || heigh > 180 || low < 30 || heigh < 30){
        return;
    }
    [self createHeaderLine:heigh];
    [self createBootomLine:low];
    [self createBgLine:heigh low:low];
}


-(void)createHeaderLine:(NSInteger)h{
    UIBezierPath *progressline = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((_lineWidth - _pillarWidth) / 2.0,(self.maxScale - h) * _oneUnit,_pillarWidth,_pillarHeight) cornerRadius:self.radius];
    [progressline setLineWidth:0.0];
    [progressline setLineCapStyle:kCGLineCapSquare];
    _headleLine.fillColor = [_HeightColor CGColor];
    _headleLine.strokeEnd = 1.0;
    _headleLine.path = progressline.CGPath;
}


-(void)createBootomLine:(NSInteger)low{
    UIBezierPath *progressline = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((_lineWidth - _pillarWidth) / 2.0,(self.maxScale - low) * _oneUnit - _pillarHeight,_pillarWidth,_pillarHeight) cornerRadius:2];
    [progressline setLineWidth:0.0];
    [progressline setLineCapStyle:kCGLineCapSquare];
    _bottomLine.fillColor = [_lowColor CGColor];
    _bottomLine.strokeEnd = 1.0;
    _bottomLine.path = progressline.CGPath;
}

-(void)createBgLine:(NSInteger)heigh low:(NSInteger)low{
    if(heigh - low <= 0){
        return;
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0.0,0.0);
    gradientLayer.endPoint = CGPointMake(0.0 ,1.0);
    gradientLayer.frame = CGRectMake((_lineWidth - _pillarWidth) / 2.0 + 1 , (self.maxScale - heigh) * _oneUnit  + _pillarHeight, _pillarWidth - 2, (heigh - low) * _oneUnit - _pillarHeight);
    
    NSMutableArray *colors = [NSMutableArray array];
    for (int i = 0; i < self.colorArr.count; i++) {
        UIColor *color = self.colorArr[i];
        [colors addObject:(__bridge id)color.CGColor];
    }
    gradientLayer.colors = colors;
    [self.layer addSublayer:gradientLayer];
}



@end
