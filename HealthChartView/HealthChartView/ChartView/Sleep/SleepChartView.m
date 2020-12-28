//
//  SleepChartView.m
//  HealthChartView
//
//  Created by MAC on 2020/12/28.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "SleepChartView.h"
#import "SleepLineView.h"
#import "SleepValueModel.h"
#import "SleepInfoModel.h"
@interface SleepChartView()

@property (strong, nonatomic)  SleepLineView *sleepLine;

///存放SleepValueModel 的数据模型
@property (strong, nonatomic) NSMutableArray <SleepValueModel *> *dataValueArr;


@end

@implementation SleepChartView

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
    self.viewClass = [SleepChartView class];
    self.moveFollowCenter = NO;
}


///将睡眠曲线转为 对应的睡眠状态
-(NSMutableArray *)analyzeLine:(NSString *)line{
    NSData *testData = [line dataUsingEncoding:NSUTF8StringEncoding];
    Byte *testByte = (Byte *)[testData bytes];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 1; i < (testData.length + 1) / 4; i++) {   //i 就是一分钟的
        Byte a = testByte[i * 4];
        int b = a >> 1;
        [arr addObject:@(b)];
    }
    return arr;
}


-(void)statusArr:(NSArray *)arr{
    if (arr.count == 0) {
        return;
    }
    //初始状态的
    int header = [arr.firstObject intValue];
    //状态的头结点
    int before = 0;
    
    ///是否只有一种状态
    BOOL isHaveOneStatus = YES;
    
    for (int i = 0; i < arr.count; i++) {
        int status = [arr[i] intValue];
        if (header != status) {
            SleepValueModel *model = [SleepValueModel new];
            model.start = before;
            model.over = i;
            model.status = header;
            [self.dataValueArr addObject:model];
            
            header = status;
            before = i;
            isHaveOneStatus = NO;
        }
    }
    
    if (isHaveOneStatus) {
        SleepValueModel *model = [SleepValueModel new];
        model.start = before;
        model.over = [arr.lastObject intValue];
        model.status = header;
        [self.dataValueArr addObject:model];
    }
    
}



-(void)reloadData{
    [self cleanSleepView];
    
    [self statusArr:self.dataArr];
    
    CGFloat chartHeight = self.frame.size.height - self.model.chartMarginTop - self.model.chartMarginBottom;
    CGFloat chartWidth = self.frame.size.width - self.model.chartMarginLeft - self.model.chartMarginRight;
    _sleepLine = [[SleepLineView alloc]initWithFrame:CGRectMake(self.model.chartMarginLeft, self.model.chartMarginTop, chartWidth, chartHeight)];
    [self addSubview:_sleepLine];
    
    _sleepLine.userInteractionEnabled = NO;

    _sleepLine.modelArr = self.modelArr;
    [_sleepLine reloadData:self.dataValueArr];
    
    [self silderViewConfiger];

}


-(void)cleanSleepView{
    [_sleepLine removeFromSuperview];
    [self.dataValueArr removeAllObjects];
}



-(void)nowOffset:(CGFloat)offset detailView:(nonnull UIView *)detailView{
    if (self.dataValueArr.count == 0) {
        return;
    }
    NSInteger all = self.dataValueArr.lastObject.over;

//    self.frame.size.width * valueModel.start / self.all;
    
    CGFloat width = self.frame.size.width - self.model.chartMarginLeft - self.model.chartMarginRight;
    
    SleepValueModel *valueModel;
    SleepInfoModel *infoModel;
    for (int i = 0; i < self.dataValueArr.count; i++) {
        SleepValueModel *model = self.dataValueArr[i];
        NSLog(@"%f-----%f",offset,self.frame.size.width * model.over / all);
        if (width * model.over / all > offset) {
            valueModel = model;
            break;
        }
    }
    if (valueModel == nil) {
        return;
    }
    for (SleepInfoModel *model in self.modelArr) {
        if (model.status == valueModel.status) {
            infoModel = model;
            break;
        }
    }
    
    NSAssert(infoModel, @"数据模型有误");
    
    if (self.sleepDelegate && [self.sleepDelegate respondsToSelector:@selector(yoSleepView:sleepInfo:valueModel:detailView:)]) {
        [self.sleepDelegate yoSleepView:self sleepInfo:infoModel valueModel:valueModel detailView:detailView];
    }
}


- (NSMutableArray<SleepValueModel *> *)dataValueArr{
    if (!_dataValueArr) {
        _dataValueArr = [NSMutableArray array];
    }
    return _dataValueArr;
}


@end
