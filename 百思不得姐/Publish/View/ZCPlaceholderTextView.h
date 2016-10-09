//
//  ZCPlaceholderTextView.h
//  百思不得姐
//
//  Created by zhangcheng on 16/9/22.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCPlaceholderTextView : UITextView

//占位文字
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

@end
