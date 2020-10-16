//
//  ECGTestViewController.m
//  HealthChartView
//
//  Created by hrrMac on 2020/6/18.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "ECGTestViewController.h"
#import "ECGChartView.h"

@interface ECGTestViewController ()

@property (strong, nonatomic) ECGChartView *bdView;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSArray *dataArr;
@property (nonatomic, assign) NSInteger number;
@property (weak, nonatomic) IBOutlet UILabel *numberTitler;

@end

@implementation ECGTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:10/255.0 green:194/255.0 blue:154/255.0 alpha:1.0];

    
    ECGChartView *bdView = [[ECGChartView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    bdView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bdView];
    
    bdView.isShowGrid = YES;
//    bdView.oneGridPoint = CGPointMake(7, 7);
    bdView.JumpType = ECGChartTypeOneLineJump;

    [bdView reloadConfig];
    [bdView reloadGrid];
    _bdView = bdView;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"heart" ofType:@"plist"];
    //当数据结构为数组时
    _dataArr = [[NSArray alloc] initWithContentsOfFile:plistPath];
//    //当数据结构为非数组时
    
}

- (IBAction)switchChange:(UISwitch *)sender {
    if (sender.isOn) {
        self.numberTitler.text = @"一条轨迹心电图";
        _bdView.JumpType = ECGChartTypeOneLineJump;
    }else{
        self.numberTitler.text = @"两条轨迹心电图";
        _bdView.JumpType = ECGChartTypeTWOLineJump;
    }
}


- (IBAction)startBtnClick:(id)sender {
    _number = 0;
    [_bdView clearData];
    [self configData];
}

- (IBAction)puseBtnClick:(id)sender {
    UIButton *btn = sender;
    if (!_timer) {
        return;
    }
    btn.selected = !btn.selected;
    if (btn.isSelected) {
        [btn setTitle:@"继续" forState:(UIControlStateNormal)];
        [_timer setFireDate:[NSDate distantFuture]];
    }else{
        [btn setTitle:@"暂停" forState:(UIControlStateNormal)];
        [_timer setFireDate:[NSDate date]];
    }
}



///开始划线
-(void)configData{
//    [_bdView clearData];
    if (_timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(refreshMap) userInfo:nil repeats:YES];
    
}

-(void)refreshMap{
    
    if (self.dataArr.count / 25 > _number) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < 25; i++) {
            NSString *str = self.dataArr[_number * 25 + i];
            [arr addObject:str];
        }
        [_bdView drawMap:arr];
        _number ++;
        
    }else{
        [_timer invalidate];
        _timer = nil;
    }
}



@end
