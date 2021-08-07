//
//  YOHRVBarView.m
//  HealthChartView
//
//  Created by HOrange on 2021/8/7.
//  Copyright © 2021 HOrange. All rights reserved.
//

#import "YOHRVBarView.h"

@implementation YOHRVBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        self.circleStoreColor = [UIColor redColor];
        self.clipsToBounds = YES;
    }
    return self;
}


-(void)createCircle:(NSArray *)data{
    NSArray *newarr = [data valueForKeyPath:@"@distinctUnionOfObjects.self"];
    //左右两边都空着
    float width = self.frame.size.width / 2.0;
    float height = self.frame.size.height;
    
    for (int i = 0; i < newarr.count; i++) {
        int h = [newarr[i] intValue];
        if (h / 210.0 * height < width / 2.0 || h > 210) {
            continue;
        }
        //创建CAShapeLayer对象
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(width / 2.0, (1 - h / 210.0) * height - width / 2.0 , width, width);//设置shapeLayer的尺寸和位置
        shapeLayer.fillColor = _circleStoreColor.CGColor;//填充颜色为ClearColor
        //设置线条的宽度和颜色
        shapeLayer.lineWidth = 0.0f;
        shapeLayer.strokeColor = _circleStoreColor.CGColor;
        UIBezierPath *aPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, width) cornerRadius:width / 2.0 ];
        shapeLayer.path = aPath.CGPath;
        [self.layer addSublayer:shapeLayer];
    }
    
}


@end
