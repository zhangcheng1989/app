//
//  ZCMessageViewController.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/5.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCMessageViewController.h"
#import "ZCMessageCell.h"
#import "ZCMessage.h"
@interface ZCMessageViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *messages;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpacing;
@property (weak, nonatomic) IBOutlet UITextField *textView;
@end


static NSString *const messageID = @"message";

@implementation ZCMessageViewController


- (NSMutableArray *)messages{
    if (!_messages) {
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"message.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *mesageAarray = [NSMutableArray array];
        ZCMessage *lastMessage = nil;
        for (NSDictionary *dict in dictArray) {
            ZCMessage *message = [ZCMessage messageWithDict:dict];
            message.hideTime = [message.time isEqualToString:lastMessage.time];
            [mesageAarray addObject:message];
            
            lastMessage = message;
        }
        _messages = mesageAarray;
        
    }
    return _messages;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCMessageCell class]) bundle:nil] forCellReuseIdentifier:messageID];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZCMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageID];
    cell.message = self.messages[indexPath.row];
    return cell;
}

#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZCMessage *message = self.messages[indexPath.row];
    return message.cellHeight;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        CGFloat ty = [UIScreen mainScreen].bounds.size.height - rect.origin.y;
        self.view.transform = CGAffineTransformMakeTranslation(0, -ty);
    }];
}

- (IBAction)voiceClick {
    
    [self.view endEditing:YES];
    
    self.textView.inputView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    [self.textView becomeFirstResponder];

}



- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//
//- (BOOL)canBecomeFirstResponder
//{
//    return YES;
//}

@end
