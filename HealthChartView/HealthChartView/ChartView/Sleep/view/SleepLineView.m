//
//  SleepLineView.m
//  HealthChartView
//
//  Created by MAC on 2020/12/28.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "SleepLineView.h"
#import "SleepInfoModel.h"
#import "SleepValueModel.h"

@interface SleepLineView()

@property (assign, nonatomic) CGFloat all;


@end

@implementation SleepLineView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self  = [super initWithCoder:coder]) {
    }
    return self;
}



-(void)reloadData:(NSMutableArray <SleepValueModel *>*)data{
    if (data.count == 0) {
        return;
    }
    self.all = data.lastObject.over;
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    for (SleepInfoModel *model in self.modelArr) {
        [dataDic setValue:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%ld",(long)model.status]];
    }
    for (SleepValueModel *model in data) {
        NSMutableArray *dataArr = dataDic[[NSString stringWithFormat:@"%ld",(long)model.status]];
        [dataArr addObject:model];
    }
    [self drawSleepLine:dataDic];
}

/**
 status:@[]
 */
-(void)drawSleepLine:(NSDictionary *)dict{
    for (SleepInfoModel *model in self.modelArr) {
        NSString *status = [NSString stringWithFormat:@"%ld",(long)model.status];
        NSMutableArray *arr = dict[status];
        if (arr.count == 0) {
            continue;
        }
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        float y = model.top * self.frame.size.height;
        float h = (model.bottom - model.top) * self.frame.size.height;
        
        for (SleepValueModel *valueModel in arr) {
            float x = self.frame.size.width * valueModel.start / self.all;
            float w = (valueModel.over - valueModel.start) / self.all * self.frame.size.width;
            UIBezierPath *aPath = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, h)];
            aPath.lineWidth = 0.0;
            [path appendPath:aPath];
        }
        
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.lineCap = kCALineCapButt;
        lineLayer.fillColor = model.color.CGColor;
//        lineLayer.lineWidth = 0.0;
        lineLayer.path = path.CGPath;
//        lineLayer.strokeColor = model.color.CGColor;
        [self.layer addSublayer:lineLayer];
    }
}


@end
