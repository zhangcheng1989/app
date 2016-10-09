//
//  ZCPopBtn.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/9.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCPopBtn.h"

@implementation ZCPopBtn

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point= [touch locationInView:self];
    
    self.transform = CGAffineTransformTranslate(self.transform, point.x, point.y);
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    
    CGPoint chatP = [self convertPoint:point toView:self.popBtn];
    
    if ([self.popBtn pointInside:chatP withEvent:event]) {
        return self.popBtn;
    }else{
       return [super hitTest:point withEvent:event]; 
    }
    
}

@end
