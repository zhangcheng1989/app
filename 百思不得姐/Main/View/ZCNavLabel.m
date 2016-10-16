//
//  ZCNavLabel.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/16.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCNavLabel.h"


#define ZCRed 0.4
#define ZCGreen 0.6
#define ZCBlue 0.7

@implementation ZCNavLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15.0];
        self.textColor = [UIColor colorWithRed:ZCRed green:ZCGreen blue:ZCBlue alpha:1.0];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor blueColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setScale:(CGFloat)scale{
    _scale = scale;
    
    
    CGFloat red = ZCRed + (1 - ZCRed)*scale;
    CGFloat green = ZCGreen + (0 - ZCGreen) *scale;
    CGFloat blue = ZCBlue+(0 - ZCBlue) *scale;
    
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    CGFloat transformScale = 1 + scale * 0.3;
    self.transform = CGAffineTransformMakeScale(transformScale,transformScale);
}


////设置左边label颜色
//leftLabel.textColor = [UIColor colorWithRed:leftScale green:leftScale blue:1-leftScale alpha:1.0];
////    leftLabel.font = [UIFont systemFontOfSize:14+leftScale  * 10];
//leftLabel.transform = CGAffineTransformMakeScale(1+leftScale, 1+leftScale);
//
////设置右边label颜色
//rightLabel.textColor = [UIColor colorWithRed:rightScale green:rightScale blue:1-rightScale alpha:1.0];
//
////    rightLabel.font = [UIFont systemFontOfSize:14+leftScale  * 10];
//rightLabel.transform = CGAffineTransformMakeScale(1+leftScale, 1+leftScale);

@end
