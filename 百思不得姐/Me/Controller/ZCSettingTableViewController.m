//
//  ZCSettingTableViewController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/26.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCSettingTableViewController.h"
#import "SDImageCache.h"
@interface ZCSettingTableViewController ()

@end

@implementation ZCSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"设置";
    self.tableView.backgroundColor =  ZCColor(223, 223, 223);
    
    NSFileManager *mg = [NSFileManager defaultManager];
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    NSDirectoryEnumerator *fileEnumerator = [mg enumeratorAtPath:cachePath];
    NSInteger total = 0;
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attr = [mg attributesOfItemAtPath:filePath error:nil];
        if ([attr[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
        total += [attr[NSFileSize]integerValue];
//        total+=size;
    }
//    NSLog(@"%@",NSTemporaryDirectory());
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    float size = [SDImageCache sharedImageCache].getSize / 1000.0 / 1000;
    
    cell.textLabel.text = [NSString stringWithFormat:@"清楚缓存(已使用%.2fMB)",size];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[SDImageCache sharedImageCache] clearDisk];
}

@end
