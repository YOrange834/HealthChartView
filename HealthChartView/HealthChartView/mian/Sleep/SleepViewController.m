//
//  SleepViewController.m
//  HealthChartView
//
//  Created by MAC on 2020/12/28.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "SleepViewController.h"
#import "SleepChartView.h"
#import "SleepLineView.h"
#import "SleepValueModel.h"
#import "SleepInfoModel.h"
@interface SleepViewController ()<YOSleepDelegate>

@end

@implementation SleepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"睡眠图";
    self.view.backgroundColor = [UIColor colorWithRed:10/255.0 green:194/255.0 blue:154/255.0 alpha:1.0];

    SleepChartView *bdView = [[SleepChartView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    bdView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bdView];
    
    bdView.xAxis.dataArr = @[];//@"01.02",@"01.03",@"01.04",@"01.05",@"01.06",@"01.07"];
    bdView.xAxis.type = YOXAxisTypeLeftToY;
    bdView.xAxis.lableColor = [UIColor whiteColor];
    
    bdView.canSilder = YES;
    bdView.lineView.backgroundColor = [UIColor redColor];
    
    bdView.moveFollowCenter = NO;
    
    
    NSMutableArray *arr = [NSMutableArray array];
    {
        SleepInfoModel *model = [SleepInfoModel new];
        model.color = [UIColor colorWithRed:27/255.0 green:131/255.0 blue:225/255.0 alpha:1.0];
        model.detail = @"深睡";
        model.top = 0.0;
        model.bottom = 1.0;
        model.status = 1;
        [arr addObject:model];
    }
    {
        SleepInfoModel *model = [SleepInfoModel new];
        model.color = [UIColor colorWithRed:75/255.0 green:9/255.0 blue:207/255.0 alpha:1.0];
        model.detail = @"浅睡";
        model.top = 0.0;
        model.bottom = 0.33;
        model.status = 2;
        [arr addObject:model];
    }
    {
        SleepInfoModel *model = [SleepInfoModel new];
        model.color = [UIColor colorWithRed:241/255.0 green:65/255.0 blue:85/255.0 alpha:1.0];
        model.detail = @"醒着";
        model.top = 0.33;
        model.bottom = 0.66;
        model.status = 3;
        [arr addObject:model];
    }
    {
        SleepInfoModel *model = [SleepInfoModel new];
        model.color = [UIColor colorWithRed:245/255.0 green:177/255.0 blue:51/255.0 alpha:1.0];
        model.detail = @"快速眼动";
        model.top = 0.66;
        model.bottom = 1.0;
        model.status = 4;
        [arr addObject:model];
    }
    
    bdView.modelArr = arr;
    
    NSMutableArray *dataArr = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        int x = 1 + arc4random() % 4;
        [dataArr addObject:@(x)];
//        [dataArr addObject:@(1)];
    }
    
    UIView *vi = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, 120, 40))];
    vi.backgroundColor = [UIColor blueColor];
    UILabel *lab = [[UILabel alloc]initWithFrame:(CGRectMake(0, 0, 120, 30))];
    lab.textColor = [UIColor whiteColor];
    [vi addSubview:lab];
    lab.tag = 102;
    
//    bdView.detailView = vi;
    [bdView detailViewConfiger:vi];
    
    bdView.sleepDelegate = self;
    
    
    bdView.dataArr = dataArr;
    [bdView reloadData];
    
}

-(void)yoSleepView:(SleepChartView *)chartView sleepInfo:(SleepInfoModel *)infoModel valueModel:(SleepValueModel *)valueModel detailView:(UIView *)detailView{
    UILabel *lab = [detailView viewWithTag:102];
    lab.text = [NSString stringWithFormat:@"%@----%ld",infoModel.detail,valueModel.over];
}


@end
