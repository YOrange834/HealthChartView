//
//  ECGScalView.m
//  BeyondHealth
//
//  Created by hrrMac on 2020/8/13.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "ECGScalView.h"
#import "ECGShareView.h"

@interface ECGScalView()

@property (weak, nonatomic) IBOutlet UILabel *brithdayLab;
@property (weak, nonatomic) IBOutlet UILabel *hrLab;
@property (weak, nonatomic) IBOutlet UILabel *qtLab;
@property (weak, nonatomic) IBOutlet UILabel *hrvLab;
@property (weak, nonatomic) IBOutlet UILabel *paramLab;
@property (weak, nonatomic) IBOutlet UILabel *recordLab;

/// 1240 - 40 * 2 - 45 * 2
@property (weak, nonatomic) IBOutlet UIView *bgView;


@end


@implementation ECGScalView


-(void)refreshMap:(NSArray *)data{
    float oneGrid = (1240 - 40 * 2 - 45 * 2.0) / (15 * 5 * 5.0);
    
    float height = oneGrid * 10 * 5;
    
    int page = ceil(data.count / (250.0 * 15.0));
    
    for (int i = 0; i < page; i++) {
        ECGShareView *shareView = [[ECGShareView alloc]initWithFrame:CGRectMake(0, i * (35 + height) , 1240 - 40 * 2 - 45 * 2, height)];
        shareView.line = i;
        [shareView configUI];
        ////250 * 15;
        if (i == page - 1) {
            [shareView drawMap:[data subarrayWithRange:NSMakeRange(i * 250 * 15, data.count - i * 250 * 15)]];
        }else{
            [shareView drawMap:[data subarrayWithRange:NSMakeRange(i * 250 * 15,250 * 15)]];
        }
        
        [self.bgView addSubview:shareView];
    }
    
    
}


@end
