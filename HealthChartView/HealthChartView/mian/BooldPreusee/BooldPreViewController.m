//
//  BooldPreViewController.m
//  HealthChartView
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "BooldPreViewController.h"
#import "YOBooldPressureView.h"

@interface BooldPreViewController ()<YOBaseChartViewDelegate>

@end

@implementation BooldPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:10/255.0 green:194/255.0 blue:154/255.0 alpha:1.0];
    
    YOBooldPressureView *bdView = [[YOBooldPressureView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    bdView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bdView];
    
    bdView.number = 20;
    
    bdView.xAxis.dataArr = @[@"01.01",@"01.20"];//@"01.02",@"01.03",@"01.04",@"01.05",@"01.06",@"01.07"];
    bdView.xAxis.type = YOXAxisTypeLeftToY;
    bdView.xAxis.lableColor = [UIColor whiteColor];
    
    bdView.yAxis.dataArr = @[@"30",@"180"];
    bdView.yAxis.lableColor = [UIColor whiteColor];
    bdView.canSilder = YES;
    bdView.lineView.backgroundColor = [UIColor redColor];
    
    UIView *vi = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, 120, 40))];
    vi.backgroundColor = [UIColor blueColor];
    UILabel *lab = [[UILabel alloc]initWithFrame:(CGRectMake(0, 0, 80, 30))];
    [vi addSubview:lab];
    lab.tag = 102;
    
//    bdView.detailView = vi;
    [bdView detailViewConfiger:vi];
    
    bdView.delegate = self;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        YOBPValueModel *model = [YOBPValueModel new];
        model.low = 75 + (arc4random() % 15);
        model.Height = 110 + + (arc4random() % 10);
        [arr addObject:model];
    }
    bdView.dataArr = arr;
    [bdView reload];
}


-(void)yoBaseChartView:(YOBaseChartView *)chartView isSilder:(BOOL)isSilder{
    NSLog(@"滑动%d",isSilder);
}


-(void)yoBaseChartView:(YOBaseChartView *)chartView selectIndex:(NSInteger)index detailView:(UIView *)detailView{
    NSLog(@"%d",index);
    UILabel *lab = [detailView viewWithTag:102];
    lab.text = [NSString stringWithFormat:@"%d",index];
}



@end
