//
//  ECGGridView.h
//  BeyondHealth
//
//  Created by hrrMac on 2020/8/13.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ECGGridView : UIView

-(void)drawGridBackgroundView;

@property (assign, nonatomic) int line;

@end

NS_ASSUME_NONNULL_END
