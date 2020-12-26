//
//  BooldOxyViewController.m
//  HealthChartView
//
//  Created by MAC on 2020/12/26.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "BooldOxyViewController.h"
#import "OxyChartView.h"

@interface BooldOxyViewController ()<YOBaseChartViewDelegate>

@end

@implementation BooldOxyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"血氧图";

    self.view.backgroundColor = [UIColor colorWithRed:10/255.0 green:194/255.0 blue:154/255.0 alpha:1.0];
    
    OxyChartView *bdView = [[OxyChartView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    bdView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bdView];
    
//    bdView.number = 8;
    
    bdView.xAxis.dataArr = @[@"●",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"●"];
    bdView.xAxis.type = YOXAxisTypeCenterToY;
    bdView.xAxis.lableColor = [UIColor whiteColor];
    
//    bdView.yAxis.dataArr = @[@"30",@"180"];
    bdView.yAxis.dataArr = @[@"70",@"90",@"100"];//@[@"●",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"●"];
    bdView.yAxis.rateArr = @[@"1",@"0.33",@"0"];
    
    
    bdView.yAxis.lableColor = [UIColor whiteColor];
    bdView.canSilder = YES;
    bdView.lineView.backgroundColor = [UIColor redColor];
    
    UIView *vi = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, 120, 40))];
    vi.backgroundColor = [UIColor blueColor];
    UILabel *lab = [[UILabel alloc]initWithFrame:(CGRectMake(0, 0, 80, 30))];
    [vi addSubview:lab];
    lab.tag = 102;
    
    [bdView detailViewConfiger:vi];
    
    bdView.delegate = self;

    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *puse = [NSMutableArray array];
    for (int i = 0; i < 42; i++) {
        [arr addObject:@"98"];
        [puse addObject:@"0"];
    }
    
    arr[7] = @"97";
    arr[25] = @"97";
    arr[32] = @"97";

    arr[15] = @"0";
    arr[16] = @"0";
    arr[17] = @"0";

    
    arr[4] = @"99";
    arr[24] = @"99";
    arr[29] = @"99";

    arr[32] = @"0";
    arr[33] = @"0";
    arr[34] = @"0";
    arr[35] = @"0";
    arr[36] = @"0";
    arr[37] = @"0";
    arr[38] = @"0";
    arr[39] = @"0";
    arr[40] = @"0";
    arr[41] = @"0";

    
    
    puse[6] = @"1";
//    puse[16] = @"1";
    puse[26] = @"1";
    puse[36] = @"1";

    bdView.dataArr = arr;
    bdView.puseArr = puse;
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
