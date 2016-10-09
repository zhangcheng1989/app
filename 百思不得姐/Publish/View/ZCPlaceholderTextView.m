//
//  ZCPlaceholderTextView.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/22.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCPlaceholderTextView.h"

@implementation ZCPlaceholderTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        //默认字体大小
        self.font = [UIFont systemFontOfSize:15.0];
        //默认占位字体颜色
        self.placeholderColor = [UIColor grayColor];
        self.alwaysBounceVertical = YES;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textDidChange
{
    [self setNeedsDisplay]; //调用drawRect
}


//每次调用drawRect会自动清除掉之前绘制的内容
- (void)drawRect:(CGRect)rect
{
    //如果有文字直接返回，不绘制占位文字
//    if (self.text.length || self.attributedText.length) return;
    
    if (self.hasText)  return; //如果有文字
    
    rect.origin.x = 4;
    rect.origin.y = 7;
    rect.size.width -= 2 * rect.origin.x;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    [self.placeholder drawInRect:rect withAttributes:attrs];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    [self setNeedsDisplay];
}


- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}


- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
