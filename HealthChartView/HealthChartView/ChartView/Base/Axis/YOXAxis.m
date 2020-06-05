//
//  YOXAxis.m
//  DawnHealth
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 hheTeamiOS. All rights reserved.
//

#import "YOXAxis.h"

@implementation YOXAxis

-(instancetype)init{
    if (self = [super init]) {
        _type = YOXAxisTypeCenterToY;
        _dataArr = @[];
        _lableFont = [UIFont systemFontOfSize:14];
        _lableColor = [UIColor grayColor];
        _lableHeight = 20;
        _labelToX = 0;
        _alignment = NSTextAlignmentCenter;
        _xColor = [UIColor grayColor];
        _xWidth = 0.5;
        _isShowX = YES;
        
    }
    return self;
}


@end
