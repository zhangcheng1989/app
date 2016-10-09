//
//  ZCCCustomViewController.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 16/9/28.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCCCustomViewController.h"
#import "ZCLineLayout.h"
#import "ZCPhotoCell.h"
#import "ZCGridLayout.h"
#import "ZCCircleLayout.h"
@interface ZCCCustomViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, weak)UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageName;
@end

static NSString *const cellID = @"photo";

@implementation ZCCCustomViewController

- (NSMutableArray *)imageName{
    if (!_imageName) {
        _imageName = [NSMutableArray array];
        
        for (NSInteger i =0; i<20; i++) {
            [_imageName addObject:[NSString stringWithFormat:@"%li",i+1]];
        }
    }
    return _imageName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    ZCCircleLayout *layot = [[ZCCircleLayout alloc]init];
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 200;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 150, width, height) collectionViewLayout:layot];
    collectionView.dataSource = self;
    collectionView.delegate = self;
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[ZCLineLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[ZCCircleLayout alloc]init] animated:YES];
    }else{
        ZCLineLayout *layout = [[ZCLineLayout alloc]init];
        layout.itemSize = CGSizeMake(100, 100);
        [self.collectionView setCollectionViewLayout:layout animated:YES];
    }
   
}

#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageName.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZCPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.imageName = self.imageName[indexPath.item];
    return cell;
}

#pragma mark --UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.imageName removeObjectAtIndex:indexPath.item];
    
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

@end
