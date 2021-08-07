//
//  MainViewController.m
//  HealthChartView
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "MainViewController.h"
#import "BooldPreViewController.h"
#import "ECGShareViewController.h"
#import "ECGTestViewController.h"
#import "BooldOxyViewController.h"
#import "SleepViewController.h"
#import "HRVViewController.h"
#import "HeartRateViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController{
    NSArray *_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HealthChartView";
    _arr = @[@"血压图",@"心电图报告",@"实时绘制心电图",@"血氧图",@"睡眠图",@"HRV",@"心率",];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _arr[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = _arr[indexPath.row];
    if ([title isEqualToString:@"血压图"]) {
        [self.navigationController pushViewController:[BooldPreViewController new] animated:YES];
        return;
    }
    if ([title isEqualToString:@"心电图报告"]) {
        [self.navigationController pushViewController:[ECGShareViewController new] animated:YES];
        return;
    }
    if ([title isEqualToString:@"实时绘制心电图"]) {
        [self.navigationController pushViewController:[ECGTestViewController new] animated:YES];
        return;
    }
    if ([title isEqualToString:@"血氧图"]) {
        [self.navigationController pushViewController:[BooldOxyViewController new] animated:YES];
        return;
    }
    if ([title isEqualToString:@"睡眠图"]) {
        [self.navigationController pushViewController:[SleepViewController new] animated:YES];
        return;
    }
    if ([title isEqualToString:@"HRV"]) {
        [self.navigationController pushViewController:[HRVViewController new] animated:YES];
        return;
    }
    if ([title isEqualToString:@"心率"]) {
        [self.navigationController pushViewController:[HeartRateViewController new] animated:YES];
        return;
    }
}

@end
