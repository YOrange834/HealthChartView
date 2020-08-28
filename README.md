# HealthChartView
健康类型项目，心电图，心率图，睡眠图，血氧，血压，HRV

#### 时间轴

1. 2020.6 血压图
2. 2020.8 心率分析报告

#### 血压

![IMG_AD9E8F629DE2-1](https://github.com/YOrange834/HealthChartView/blob/master/source/IMG_AD9E8F629DE2-1.jpeg)

#### 使用方法

#### 血压

```objective-c
// 创建视图
YOBooldPressureView *bdView = [[YOBooldPressureView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
bdView.backgroundColor = [UIColor clearColor];
[self.view addSubview:bdView];

// 设置X轴
bdView.number = 20;
    
bdView.xAxis.dataArr = @[@"01.01",@"01.20"];//@"01.02",@"01.03",@"01.04",@"01.05",@"01.06",@"01.07"];
bdView.xAxis.type = YOXAxisTypeLeftToY;
bdView.xAxis.lableColor = [UIColor whiteColor];

// 设置Y轴
bdView.yAxis.dataArr = @[@"30",@"180"];
bdView.yAxis.lableColor = [UIColor whiteColor];

//设置数据详情视图，和视图回调代理
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

-(void)yoBaseChartView:(YOBaseChartView *)chartView isSilder:(BOOL)isSilder{
    NSLog(@"滑动%d",isSilder);
}


-(void)yoBaseChartView:(YOBaseChartView *)chartView selectIndex:(NSInteger)index detailView:(UIView *)detailView{
    NSLog(@"%d",index);
    UILabel *lab = [detailView viewWithTag:102];
    lab.text = [NSString stringWithFormat:@"%d",index];
}

// 刷新视图
NSMutableArray *arr = [NSMutableArray array];
for (int i = 0; i < 20; i++) {
    YOBPValueModel *model = [YOBPValueModel new];
    model.low = 75 + (arc4random() % 15);
    model.Height = 110 + + (arc4random() % 10);
    [arr addObject:model];
}
bdView.dataArr = arr;
[bdView reload];
```

#### 心电图

![https://github.com/YOrange834/HealthChartView/blob/master/source/IMG_0012.JPG]()

