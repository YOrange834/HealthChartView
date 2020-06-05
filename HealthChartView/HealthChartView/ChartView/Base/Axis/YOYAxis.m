//
//  YOYAxis.m
//  DawnHealth
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 hheTeamiOS. All rights reserved.
//

#import "YOYAxis.h"

@implementation YOYAxis

-(instancetype)init{
    if (self = [super init]) {
        _dataArr = @[];
        _lableFont = [UIFont systemFontOfSize:14];
        _lableColor = [UIColor grayColor];
        _yColor = [UIColor grayColor];
        _yWidth = 0.5;
        _isShowY = YES;
    }
    return self;
}


@end
