//
//  HRVViewController.m
//  HealthChartView
//
//  Created by HOrange on 2021/8/7.
//  Copyright © 2021 HOrange. All rights reserved.
//

#import "HRVViewController.h"
#import "YOHRVChartView.h"

@interface HRVViewController ()<YOBaseChartViewDelegate>

@end

@implementation HRVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HRV";
    self.view.backgroundColor = [UIColor colorWithRed:10/255.0 green:194/255.0 blue:154/255.0 alpha:1.0];

    NSString *path =[[NSBundle mainBundle] pathForResource:@"hahah" ofType:@"plist"];
    NSArray * dataArr = [[NSArray alloc]initWithContentsOfFile:path];
    
    YOHRVChartView *bdView = [[YOHRVChartView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    bdView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bdView];

    bdView.xAxis.dataArr = @[@"●",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"●"];
    bdView.xAxis.type = YOXAxisTypeCenterToY;
    bdView.xAxis.lableColor = [UIColor whiteColor];
    
    
    bdView.yAxis.dataArr = @[@"0",@"100",@"210"];
    bdView.yAxis.rateArr = @[@"1",@"0.33",@"0"];
    
    
    bdView.yAxis.lableColor = [UIColor whiteColor];
    bdView.canSilder = NO;
    bdView.lineView.backgroundColor = [UIColor clearColor];
    
    
//    UIView *vi = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, 120, 40))];
//    vi.backgroundColor = [UIColor blueColor];
//    UILabel *lab = [[UILabel alloc]initWithFrame:(CGRectMake(0, 0, 80, 30))];
//    [vi addSubview:lab];
//    lab.tag = 102;
//    
//    [bdView detailViewConfiger:vi];
//    
//    bdView.delegate = self;
    
    
    bdView.dataArr = dataArr;
    [bdView reload];
}


-(void)yoBaseChartView:(YOBaseChartView *)chartView isSilder:(BOOL)isSilder{
    NSLog(@"滑动%d",isSilder);
}


-(void)yoBaseChartView:(YOBaseChartView *)chartView selectIndex:(NSInteger)index detailView:(UIView *)detailView{
    NSLog(@"%ld",(long)index);
    UILabel *lab = [detailView viewWithTag:102];
    lab.textColor = [UIColor whiteColor];
    lab.text = [NSString stringWithFormat:@"血氧%ld",(long)index];
}

@end
