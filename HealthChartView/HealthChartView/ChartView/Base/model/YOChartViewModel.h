//
//  YOChartViewModel.h
//  DawnHealth
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 hheTeamiOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YOChartViewModel : NSObject

///图标距离视图左边的距离 (Y轴的刻度在这个里面) 默认 25
@property (assign, nonatomic) CGFloat chartMarginLeft;

///图标距离视图右边的距离 默认 25
@property (assign, nonatomic) CGFloat chartMarginRight;

///图标距离视图顶部边的距离 默认 25
@property (assign, nonatomic) CGFloat chartMarginTop;

///图标距离视图底边的距离 (X轴的刻度在这个里面) 默认 25
@property (assign, nonatomic) CGFloat chartMarginBottom;




@end

NS_ASSUME_NONNULL_END
