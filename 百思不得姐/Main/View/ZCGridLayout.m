//
//  ZCGridLayout.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/4.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCGridLayout.h"

@interface ZCGridLayout()
@property (nonatomic, strong) NSMutableArray *attrsArray;
@end

@implementation ZCGridLayout

- (NSMutableArray *)attrsArray{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    [self.attrsArray removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i =0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //创建UICollectionViewLayoutAttributes
        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGFloat width = self.collectionView.frame.size.width * 0.5;
        CGFloat height = width;
        CGFloat x = 0;
        CGFloat y = 0;
        attrs.frame = CGRectMake(0, 0, width, height);
        
        [self.attrsArray addObject:attrs];

    }
    

    

}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.attrsArray;
}


- (CGSize)collectionViewContentSize{

    NSInteger count = [self.collectionView numberOfItemsInSection:0];

    NSInteger rows = (count + 3-1)/3;
    CGFloat rowH = self.collectionView.frame.size.width * 0.5;
    
    return CGSizeMake(0, rows * rowH);
}

@end
