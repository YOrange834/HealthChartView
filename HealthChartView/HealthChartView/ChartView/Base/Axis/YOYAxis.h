//
//  YOYAxis.h
//  DawnHealth
//
//  Created by hrrMac on 2020/6/5.
//  Copyright © 2020 hheTeamiOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YOYAxis : NSObject

///X轴的坐标内容
@property (strong, nonatomic) NSArray *dataArr;

///字体大小 默认14
@property (strong, nonatomic) UIFont *lableFont;

///字体颜色
@property (strong, nonatomic) UIColor *lableColor;

///X轴颜色
@property (strong, nonatomic) UIColor *yColor;
///X轴宽度 默认 1.0
@property (assign, nonatomic) CGFloat yWidth;

///是否展示出来，默认展示
@property (assign, nonatomic) BOOL isShowY;



@end

NS_ASSUME_NONNULL_END
