//
//  ZCCircleLayout.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/4.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCCircleLayout.h"

@interface ZCCircleLayout()
@property (nonatomic, strong) NSMutableArray *attrs;
@end

@implementation ZCCircleLayout

- (NSMutableArray *)attrs{
    if (!_attrs) {
        _attrs = [NSMutableArray array];
    }
    return _attrs;
}

- (void)prepareLayout{
    [super prepareLayout];
    
    [self.attrs removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i =0 ; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrs addObject:attr];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat radius = 100;
    CGFloat oX = self.collectionView.frame.size.width * 0.5;
    CGFloat oY = self.collectionView.frame.size.height * 0.5;
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
    attr.size = CGSizeMake(50, 50);
    if (count == 1) {
        attr.center = CGPointMake(oX, oY);
    }
    CGFloat angle = (2 * M_PI/count) * indexPath.item;
    CGFloat centerX = oX + radius * sin(angle);
    CGFloat centerY = oY + radius * cos(angle);
    
    attr.center = CGPointMake(centerX, centerY);
    
    return attr;
}


@end
