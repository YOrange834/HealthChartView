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

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController{
    NSArray *_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _arr = @[@"血压图",@"心电图报告"];
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
    }
    //
}

@end
