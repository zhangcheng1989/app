//
//  ZCProgressView.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/6.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCProgressView.h"

@implementation ZCProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}


- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%d%%",(int)progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
