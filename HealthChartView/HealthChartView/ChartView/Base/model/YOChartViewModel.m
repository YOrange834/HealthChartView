//
//  YOChartViewModel.m
//  DawnHealth
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 hheTeamiOS. All rights reserved.
//

#import "YOChartViewModel.h"

@implementation YOChartViewModel

-(instancetype)init{
    if (self = [super init]) {
        _chartMarginLeft     = 25.0;
        _chartMarginRight    = 25.0;
        _chartMarginTop      = 25.0;
        _chartMarginBottom   = 25.0;
    }
    return self;
}


@end
