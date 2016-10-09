//
//  ZCWaterViewController.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/4.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCWaterViewController.h"
#import "ZCWaterLayout.h"
#import "ZCShop.h"
@interface ZCWaterViewController ()<UICollectionViewDataSource,ZCWaterLayoutDelegate>
@property (nonatomic, strong) NSMutableArray *shops;
@end

static NSString *const ZCShopId = @"shop";

@implementation ZCWaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZCWaterLayout *layout = [[ZCWaterLayout alloc]init];
    layout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ZCShopId];
}



#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZCShopId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

#pragma mark --ZCWaterLayoutDelegate
- (CGFloat)waterLayout:(ZCWaterLayout *)waterLayout heightForItemAtIndex:(NSUInteger)index itemWith:(CGFloat)itemWith{
    
    ZCShop *shop = self.shops[index];
    
    return  itemWith * shop.h / shop.w;
}

@end
