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

///详情参数视图
@property (strong, nonatomic) UIView *detailView;

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
    _canSilder = NO;
    _isTop = YES;
    _moveFollowCenter = YES;
    _copies = 42;
}


#pragma mark - X轴与 Y轴
///画Y轴
-(void)drawYLabel{
    if (self.yAxis.dataArr.count == 0) {
        return;
    }
    float sectionHeight = self.frame.size.height - self.model.chartMarginTop - self.model.chartMarginBottom;

    if (self.yAxis.rateArr.count != 0) {
        NSAssert(self.yAxis.rateArr.count == self.yAxis.dataArr.count, @"内容数组和刻度数组长度要一致");
    }
    
    //均分
    BOOL isAvg = YES;
    CGFloat onePoint; //一份的高度
    
    if(self.yAxis.rateArr.count != 0){
        isAvg = NO;
        onePoint = sectionHeight / ([self.yAxis.rateArr.lastObject floatValue] - [self.yAxis.rateArr.firstObject floatValue]);
    }else{
        if (self.yAxis.dataArr.count == 1) {
            onePoint = sectionHeight;
        }else{
            onePoint = sectionHeight / (self.yAxis.dataArr.count - 1);
        }
    }
    
    for(int i = 0; i < self.yAxis.dataArr.count; i++){
        float y = self.model.chartMarginTop - self.yAxis.lableHeight / 2;
        if (isAvg) {
            y = y + sectionHeight - onePoint * i;
        }else{
            y = y + sectionHeight - onePoint * ([self.yAxis.rateArr[i] floatValue] - [self.yAxis.rateArr.firstObject floatValue]);
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, self.model.chartMarginLeft, self.yAxis.lableHeight)];
        label.font = self.yAxis.lableFont;
        label.textColor = self.yAxis.lableColor;
        [label setTextAlignment:self.yAxis.alignment];
        label.text = self.yAxis.dataArr[i];;
        [self addSubview:label];
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
    [self drawYLabel];
    [self drawAxsiLine];
}


///清除所有视图
-(void)cleanView:(NSMutableArray *)arr{
    if (arr.count > 0) {
        [arr makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [arr removeAllObjects];
    }
}

///设置滑动线的层级顺序
-(void)silderViewConfiger{
    if (_isTop) {
        [self bringSubviewToFront:self.lineView];
    }
    [self bringSubviewToFront:self.detailView];
}


-(void)detailViewConfiger:(UIView *)detailView{
    self.detailView = detailView;
    self.detailView.hidden = YES;
    [self addSubview:self.detailView];
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



-(void)moveLine:(NSSet<UITouch *> *)touches{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    UIView *subview = [self hitTest:point withEvent:nil];
    if (![subview isKindOfClass:self.viewClass]) {
//        NSLog(@"选中的是哪个tag%ld",(long)subview.tag);
        return;
    }

    if (_moveFollowCenter) { //柱体中间
        [self followCenter:point subView:subview];
    }else{  //跟随手指一动
        [self followTouch:point subView:subview];
    }
}


///跟随柱体的中间，即只会中一个柱体的中线切换到另外一个柱体的中线
-(void)followCenter:(CGPoint)point subView:(UIView *)subview{
    
    CGFloat x = point.x;
    CGRect frame = subview.frame;
    frame.origin.x += subview.frame.size.width / 2.0;
    frame.size.width = 0.5;
    frame.origin.y = 0;
    frame.size.height += self.model.chartMarginTop;
    self.lineView.frame = frame;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(yoBaseChartView:selectIndex:detailView:)]) {
        [self.delegate yoBaseChartView:self selectIndex:subview.tag - 100 detailView:self.detailView];
    }
    
    x = frame.origin.x;
    
    CGRect fr = self.detailView.frame;
    if (x < self.detailView.frame.size.width / 2) {
        fr.origin.x = 0;
    }else if (x > self.frame.size.width - self.detailView.frame.size.width / 2){
        fr.origin.x = self.frame.size.width - self.detailView.frame.size.width;
    }else{
        fr.origin.x = x - self.detailView.frame.size.width / 2;
    }
    self.detailView.frame = fr;
    
}


-(void)followTouch:(CGPoint)point subView:(UIView *)subview{
    CGFloat x = point.x;
    
    CGRect frame = self.lineView.frame;
    if(point.x < self.model.chartMarginLeft){
        frame.origin.x = self.model.chartMarginLeft;
    }else if(point.x > self.frame.size.width - self.model.chartMarginRight){
        frame.origin.x = self.frame.size.width - self.model.chartMarginRight;
    }else{
        frame.origin.x = point.x;
    }
    self.lineView.frame = frame;
    
    float allWidth = self.frame.size.width - self.model.chartMarginLeft - self.model.chartMarginRight;
    float one = allWidth / _copies;
    int index = 0;
    if (x <= self.model.chartMarginLeft) {
        index = 0;
    }else if (x >= self.frame.size.width - self.model.chartMarginRight){
        index = _copies - 1;
    }else{
        index = (int)(x - self.model.chartMarginLeft + one / 2.0) / one;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(yoBaseChartView:selectIndex:detailView:)]) {
        [self.delegate yoBaseChartView:self selectIndex:index detailView:self.detailView];
    }
    
    x = frame.origin.x;
    
    CGRect fr = self.detailView.frame;
    if (x < self.detailView.frame.size.width / 2) {
        fr.origin.x = 0;
    }else if (x > self.frame.size.width - self.detailView.frame.size.width / 2){
        fr.origin.x = self.frame.size.width - self.detailView.frame.size.width;
    }else{
        fr.origin.x = x - self.detailView.frame.size.width / 2;
    }
    self.detailView.frame = fr;
    
    [self nowOffset:point.x - self.model.chartMarginLeft detailView:self.detailView];

    
}

///滑动现在的偏移量:(子类可以重新次方法)
-(void)nowOffset:(CGFloat)offset detailView:(UIView *)detailView{
    
}


#pragma mark - touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self show:YES];
    [self moveLine:touches];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self moveLine:touches];
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self moveLine:touches];
    [self show:NO];
}


-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self show:NO];
}


-(void)show:(BOOL)isShow{
    self.lineView.hidden = !isShow;
    self.detailView.hidden = !isShow;
    if(self.delegate && [self.delegate respondsToSelector:@selector(yoBaseChartView:isSilder:)]){
        [self.delegate yoBaseChartView:self isSilder:isShow];
    }
    
}




@end
