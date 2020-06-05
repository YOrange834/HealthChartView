//
//  YOXAxis.h
//  DawnHealth
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 hheTeamiOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, YOXAxisType) {
    YOXAxisTypeCenterToY,
    YOXAxisTypeLeftToY,
};


@interface YOXAxis : NSObject

///X轴的坐标内容
@property (strong, nonatomic) NSArray *dataArr;

/**
 1.        |
           |
         10.25
 
 2.        |
           |       |
             10.25
 */

///布局方式 1.第一个内容与Y轴中心点重合，2第一个内容左边距与Y轴重合 默认中间布局
@property (assign, nonatomic) YOXAxisType type;

///字体大小 默认14
@property (strong, nonatomic) UIFont *lableFont;

///字体颜色
@property (strong, nonatomic) UIColor *lableColor;

///空间的高度 默认 20
@property (assign, nonatomic) CGFloat lableHeight;

///对齐方式，默认中间对齐
@property (assign, nonatomic) NSTextAlignment alignment;

/// 刻度距离X轴的距离， 默认0
@property (assign, nonatomic) CGFloat labelToX;

///X轴颜色
@property (strong, nonatomic) UIColor *xColor;
///X轴宽度 默认 0.5
@property (assign, nonatomic) CGFloat xWidth;

///是否展示出来，默认展示
@property (assign, nonatomic) BOOL isShowX;


@end

NS_ASSUME_NONNULL_END
