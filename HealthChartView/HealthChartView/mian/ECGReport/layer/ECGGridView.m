//
//  ECGGridView.m
//  BeyondHealth
//
//  Created by hrrMac on 2020/8/13.
//  Copyright © 2020 HOrange. All rights reserved.
//

#import "ECGGridView.h"

@implementation ECGGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}


-(void)drawGridBackgroundView{
    float oneGrid = self.frame.size.width / (15 * 5 * 5);
    
    float height = oneGrid * 10 * 5;

    CAShapeLayer *chartLevelLine = [CAShapeLayer layer];
    chartLevelLine.lineCap      = kCALineCapButt;
    chartLevelLine.fillColor    = [[UIColor whiteColor] CGColor];
    chartLevelLine.lineWidth    = 0.5;
    chartLevelLine.strokeEnd    = 0.0;

    UIBezierPath *progressline = [UIBezierPath bezierPath];
    
    UIBezierPath *bigProgressline = [UIBezierPath bezierPath];

    for (int i = 0; i <= 40; i++) {
        if (i % 5 == 0) {
            [bigProgressline moveToPoint:CGPointMake(0, oneGrid * i )];
            [bigProgressline addLineToPoint:CGPointMake(self.frame.size.width ,oneGrid * i)];
        }else{
            [progressline moveToPoint:CGPointMake(0, oneGrid * i )];
            [progressline addLineToPoint:CGPointMake(self.frame.size.width ,oneGrid * i)];
        }
    }
    for (int i = 0; i <= 15 * 5 * 5; i++) {
        if (i % 5 == 0) {
            if (i % 25 == 0) {
                [bigProgressline moveToPoint:CGPointMake(oneGrid * i, 0 )];
                [bigProgressline addLineToPoint:CGPointMake(oneGrid * i ,height)];
                
                UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(oneGrid * i + 3,oneGrid * 40.0 , oneGrid * 5 * 5, oneGrid * 10)];
                lab.font = [UIFont systemFontOfSize:16];
                lab.text = [NSString stringWithFormat:@"%dS",_line * 15 + i / 25];
                [self addSubview:lab];
            }else{
                [bigProgressline moveToPoint:CGPointMake(oneGrid * i, 0 )];
                [bigProgressline addLineToPoint:CGPointMake(oneGrid * i ,oneGrid * 40.0)];
            }
            
            
            
        }else{
            [progressline moveToPoint:CGPointMake(oneGrid * i, 0 )];
            [progressline addLineToPoint:CGPointMake(oneGrid * i ,oneGrid * 40.0)];
        }
        
        
        
    }
    
   
    {
        [progressline setLineWidth:0.0];
        [progressline setLineCapStyle:kCGLineCapSquare];
        chartLevelLine.path = progressline.CGPath;

        chartLevelLine.strokeColor = [[ECGGridView hexStringToColor:@"#EEEEEE"] CGColor] ;
        chartLevelLine.strokeEnd = 1.0;
    }

    
    
    
    [self.layer addSublayer:chartLevelLine];
    
    
    {
           CAShapeLayer *chartBigLevelLine = [CAShapeLayer layer];
           chartBigLevelLine.lineCap      = kCALineCapButt;
           chartBigLevelLine.fillColor    = [[UIColor whiteColor] CGColor];
           chartBigLevelLine.lineWidth    = 0.5;
           chartBigLevelLine.strokeEnd    = 0.0;
           
           [bigProgressline setLineWidth:0.0];
           [bigProgressline setLineCapStyle:kCGLineCapSquare];
           
           chartBigLevelLine.path = bigProgressline.CGPath;
        chartBigLevelLine.strokeColor = [[ECGGridView hexStringToColor:@"#999999"] CGColor] ;
           chartBigLevelLine.strokeEnd = 1.0;
           
           [self.layer addSublayer:chartBigLevelLine];

       }
    
}

+(UIColor *)hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



@end
