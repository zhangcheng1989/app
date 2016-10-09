//
//  ZCLineLayout.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/3.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCLineLayout.h"

@implementation ZCLineLayout



- (instancetype)init{
    if (self == [super init]) {

    }
    return self;
}


/**
 用来做布局初始化操作
 **/
- (void)prepareLayout{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

//当collectionView显示范围发生改变的时候，是否需要重新刷新布局
//一旦重新刷新布局就会调用
//prepareLayout
//layoutAttributesForElementsInRect
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


/**
 返回数组里面存放着rect范围内所有元素的布局属性
 这个方法决定了rect范围内所有元素的排布(rect)
 **/
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width *0.5;
    
    for (UICollectionViewLayoutAttributes *attr in array) {
        //cell 的中心点的x 和collectionView最中心点的x值 的间距
        CGFloat delta = ABS(attr.center.x - centerX);
        //根据间距计算cell的缩放比例
        CGFloat scale = 1.0 - delta / self.collectionView.frame.size.width;
        
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;
}


/**
 
 **/
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    //获取super 已经计算好的布局属性
    NSArray *array =  [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in array) {
        if (ABS(minDelta) > ABS(attr.center.x - centerX)){
            minDelta = attr.center.x - centerX;
        }
    }
    
    //修改原有偏移量
    proposedContentOffset.x += minDelta;
    
    return proposedContentOffset;
}

@end
