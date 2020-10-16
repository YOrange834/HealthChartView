//
//  ECGShareView.h
//  BeyondHealth
//
//  Created by hrrMac on 2020/8/13.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ECGShareView : UIView

-(void)configUI;

//250 * 15;
-(void)drawMap:(NSArray *)arr;

-(void)clearData;

@property (assign, nonatomic) int line;


@end

NS_ASSUME_NONNULL_END
