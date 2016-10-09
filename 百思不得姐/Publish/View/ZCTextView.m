//
//  ZCTextView.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/23.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTextView.h"

@interface ZCTextView()
@property (nonatomic, strong) UILabel *placeholderLabel;
@end

@implementation ZCTextView

- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        self.placeholderLabel = [[UILabel alloc]init];
        self.placeholderLabel.numberOfLines = 0;
        self.placeholderLabel.x = 4;
        self.placeholderLabel.y = 7;
        [self addSubview:self.placeholderLabel];
        
    }
    return _placeholderLabel;
}

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
    self.placeholderLabel.hidden = self.hasText;
}

- (void)updateLabelSize
{
//    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * self.placeholderLabel.x, MAXFLOAT);
//    
//    self.placeholderLabel.size = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    
//    self.placeholderLabel.width = [UIScreen mainScreen].bounds.size.width  - 2 * self.placeholderLabel.x;
//    
//    [self.placeholderLabel sizeToFit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeholderLabel.width = self.width  - 2 * self.placeholderLabel.x;
    
    [self.placeholderLabel sizeToFit];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
 
    self.placeholderLabel.text = placeholder;
    
    [self setNeedsLayout];
    
  
}


- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}


- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#warning setNeedsLayout和setNeedsDisplay区别

/**
 [self setNeedsLayout]; //会在恰当的时候调用layoutSubviews
 
 [self setNeedsDisplay]; //会在恰当的时候调用drawRect
 
 **/
@end
