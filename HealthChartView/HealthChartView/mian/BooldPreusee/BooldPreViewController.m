//
//  BooldPreViewController.m
//  HealthChartView
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "BooldPreViewController.h"
#import "YOBooldPressureView.h"

@interface BooldPreViewController ()

@end

@implementation BooldPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    YOBooldPressureView *bdView = [[YOBooldPressureView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    bdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bdView];
    
    bdView.number = 20;
    
    bdView.xAxis.dataArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天"];
    bdView.xAxis.type = YOXAxisTypeLeftToY;
    
    bdView.yAxis.dataArr = @[@"30",@"180"];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        YOBPValueModel *model = [YOBPValueModel new];
        model.low = 70 + (arc4random() % 10);
        model.Height = 110 + + (arc4random() % 10);
        [arr addObject:model];
    }
    bdView.dataArr = arr;
    [bdView reload];
    
    
    
}



@end
