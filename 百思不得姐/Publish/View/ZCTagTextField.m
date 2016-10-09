//
//  ZCTagTextField.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/25.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTagTextField.h"

@implementation ZCTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或者换行隔开";
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = 25;
    }
    return self;
}

- (void)deleteBackward
{
    !self.deleteBlock?:self.deleteBlock();
    
    [super deleteBackward];
    
}

@end
