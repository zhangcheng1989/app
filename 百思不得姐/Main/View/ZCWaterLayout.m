//
//  ZCWaterLayout.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/4.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCWaterLayout.h"

//每一列间距
static const CGFloat ZCDefaultColumnMargin = 10;
//每一行间距
static const CGFloat ZCDefaultRowMargin = 10;
//间距
static const UIEdgeInsets ZCDefaultEdgeInset = {10,10,10,10};
//默认列数
static const NSInteger ZCDefaultColumnCount = 3;


@interface ZCWaterLayout()
@property (nonatomic, strong) NSMutableArray *attrs;
//存放所有列的高度
@property (nonatomic, strong) NSMutableArray *columnHeights;
//内容高度
@property (nonatomic, assign) CGFloat contentHeight;
@end

@implementation ZCWaterLayout


- (CGFloat)columnMargin{
    if ([self.delegate respondsToSelector:@selector(layoutColumnMargin:)]) {
        return [self.delegate layoutColumnMargin:self];
    }else{
        return ZCDefaultColumnMargin;
    }
}


- (CGFloat)rowMargin{
    if ([self.delegate respondsToSelector:@selector(layoutRowMargin:)]) {
        return [self.delegate layoutRowMargin:self];
    }else{
        return ZCDefaultRowMargin;
    }
}

- (NSInteger)ColumnCount{
    if ([self.delegate respondsToSelector:@selector(layoutColumnCount:)]) {
        return [self.delegate layoutColumnCount:self];
    }else{
        return ZCDefaultColumnCount;
    }
}

- (UIEdgeInsets)EdgeInset{
    if ([self.delegate respondsToSelector:@selector(layoutEdgeInset:)]) {
        return [self.delegate layoutEdgeInset:self];
    }else{
        return ZCDefaultEdgeInset;
    }
}

- (NSMutableArray *)attrs{
    if (!_attrs) {
        _attrs = [NSMutableArray array];
    }
    return _attrs;
}

- (NSMutableArray *)columnHeights{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (void)prepareLayout{
    [super prepareLayout];
    
    self.contentHeight = 0;
    
    //清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i =0; i<self.ColumnCount; i++) {
        [self.columnHeights addObject:@(self.EdgeInset.top)];
    }
    
    [self.attrs removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i =0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrs addObject:attr];
        
    }
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.attrs;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat w = (self.collectionView.frame.size.width - self.EdgeInset.left-self.EdgeInset.right- (self.ColumnCount - 1) * self.columnMargin)/self.ColumnCount;
    CGFloat h =  50 + arc4random_uniform(100);
    
    
    //找出高度最短的那一列
//    __block NSInteger destColumn = 0;
//    __block CGFloat minColunmHeight = MAXFLOAT;
//    [self.columnHeights enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSNumber *columnHeightNumber = (NSNumber *)obj;
//        CGFloat columnHeight = columnHeightNumber.doubleValue;
//        if (minColunmHeight > columnHeight) {
//            minColunmHeight +=columnHeight;
//            destColumn = idx;
//        }
//    }];
    
    
    NSInteger destColumn = 0;
    CGFloat minColunmHeight = [self.columnHeights[0] doubleValue];
    
    for (NSInteger i = 1; i<self.ColumnCount; i++) {
        
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (minColunmHeight > columnHeight) {
            minColunmHeight = columnHeight;
            destColumn = i;
        }
   
    }
    
    CGFloat x = self.EdgeInset.left + destColumn * (w + self.columnMargin);
    CGFloat y = minColunmHeight;
    if (y != self.EdgeInset.top) {
        y += self.rowMargin;
    }
    
    attr.frame = CGRectMake(x, y, w, h);
    //更新最短列高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attr.frame));
    
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    //记录内容高度
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    
    return attr;
}

- (CGSize)collectionViewContentSize{
    
//    CGFloat maxColunmHeight = [self.columnHeights[0] doubleValue];
//    for (NSInteger i = 1; i<defaultColumnCount; i++) {
//        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
//        
//        if (maxColunmHeight < columnHeight) {
//            maxColunmHeight = columnHeight;
//        }
//    }

    return CGSizeMake(0, self.contentHeight + self.EdgeInset.bottom);
}

@end
