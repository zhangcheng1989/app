//
//  ZCTextField.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/28.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTextField.h"
#import <objc/runtime.h>

static NSString *const placeholderKeyPath = @"_placeholderLabel.textColor";

@implementation ZCTextField
//
//
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    [self.placeholder drawInRect:CGRectMake(0, 10, rect.size.width, 25) withAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],
//                                                       NSFontAttributeName:self.font}];
//}

//
//+ (void)initialize
//{
//    unsigned int count = 0;
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    
//    for (int i=0; i<count; i++) {
//        Ivar ivar = *(ivars + i);
//         Ivar ivar = ivars[i];
//        NSLog(@"%s",ivar_getName(ivar));
//    }
//    
//    
//    //释放
//    free(ivars);
//}

- (void)awakeFromNib
{
//    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [super awakeFromNib];
    
    self.tintColor = self.textColor;
    
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:placeholderKeyPath];

    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    
    [self setValue:[UIColor grayColor] forKeyPath:placeholderKeyPath];
    return [super resignFirstResponder];
}


//- (void)setHighlighted:(BOOL)highlighted
//{
//    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
//
//}

@end
