//
//  ECGShareViewController.m
//  BeyondHealth
//
//  Created by hrrMac on 2020/8/13.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "ECGShareViewController.h"
#import "ECGScalView.h"

#define MaxSCale 20.0  //最大缩放比例
#define MinScale 0.0001  //最小缩放比例

//获取屏幕的高度
#define SCREEN_HEIGHT       [[UIScreen mainScreen] bounds].size.height

//获取屏幕的宽度
#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width


@interface ECGShareViewController ()<UIScrollViewDelegate>

@property (nonatomic,assign) CGFloat totalScale; ///< 用于记录视图即时的缩放比例


@property (nonatomic, strong) ECGScalView *ecgView;

@end

@implementation ECGShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ECG REPORT";

    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:scrollView];
    
    
    ECGScalView *ecgView = [[[NSBundle mainBundle]loadNibNamed:@"ECGScalView" owner:self options:nil]lastObject];
    _ecgView = ecgView;
    ecgView.frame = CGRectMake(0, 0, 2480 / 2.0, 3508 / 2.0);
//    ecgView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:ecgView];
    
    scrollView.contentSize = CGSizeMake(2480 / 2.0, 3508 / 2.0);
//    scrollView.contentOffset =  CGPointMake(3720 / 4.0 , 5262 / 4.0);
    
    [scrollView addSubview:ecgView];
    
    scrollView.delegate = self;
    scrollView.minimumZoomScale = SCREEN_WIDTH / 1240.0; //0.01f;    // 最小缩放
    scrollView.maximumZoomScale = 1.f;    // 最大缩放
    
    [scrollView setZoomScale:scrollView.minimumZoomScale];    // 初始时候的缩放值
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];//创建手势
    [ecgView setUserInteractionEnabled:YES]; //设置启用用户交互

    [ecgView addGestureRecognizer:pan];//把手势添加到控件
    
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"heart" ofType:@"plist"];
        //当数据结构为数组时
    NSArray *dataArr = [[NSArray alloc] initWithContentsOfFile:plistPath];
    //    //当数据结构为非数组时
    
    [ecgView refreshMap:dataArr];
    
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  for (UIView *v in scrollView.subviews) {
    return v;
  }
  return nil;
}



- (void) handlePan: (UIPanGestureRecognizer *)rec{

    // NSLog(@"xxoo---xxoo---xxoo");

    CGPoint point = [rec translationInView:self.view];

    //该方法返回在横坐标上、纵坐标上拖动了多少像素

    NSLog(@"%f,%f",point.x,point.y);

    rec.view.center = CGPointMake(rec.view.center.x + point.x, rec.view.center.y + point.y);

    //rec.view 指的是把rec添加到那个控件上的

    // 因为拖动起来一直是在递增，所以每次都要用setTranslation:方法制0这样才不至于不受控制般滑动出视图

    [rec setTranslation:CGPointMake(0, 0) inView:self.view];

}



@end
