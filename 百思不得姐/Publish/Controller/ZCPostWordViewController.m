//
//  ZCPostWordViewController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCPostWordViewController.h"
#import "ZCTextView.h"
#import "ZCAddTagToolBar.h"
@interface ZCPostWordViewController ()<UITextViewDelegate>
@property (nonatomic, strong) ZCAddTagToolBar *toolBar;
@property (nonatomic, weak)  ZCTextView *textView;
@end

@implementation ZCPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpTextView];
    
    [self setUpToolBar];

}

- (void)setUpNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    //[self.navigationController.navigationBar layoutIfNeeded]; //强制刷新
}

- (void)setUpTextView
{
    ZCTextView *textView = [[ZCTextView alloc]init];
    textView.frame = self.view.bounds;
    textView.placeholderColor = [UIColor grayColor];
    textView.placeholder = @"把好玩的图片，好笑的段子或者糗事发到这里，接受千万网友的膜拜！发布违反国家法律内容，我们将依法提交有关部门处理。";
    textView.delegate = self;
    [textView becomeFirstResponder];
//    textView.inputAccessoryView = [ZCAddTagToolBar viewFromXib];
    [self.view addSubview:textView];
    self.textView = textView;
}

- (void)setUpToolBar
{
    self.toolBar = [ZCAddTagToolBar viewFromXib];
    self.toolBar.width = self.view.width;
    self.toolBar.y = self.view.height - self.toolBar.height;
    [self.view addSubview:self.toolBar];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.view endEditing:YES];
    [self.textView becomeFirstResponder];
}

- (void)keyBoardWillChangeFrame:(NSNotification *)note
{
    
    CGRect keyBoardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
       self.toolBar.transform = CGAffineTransformMakeTranslation(0, keyBoardF.origin.y - [UIScreen mainScreen].bounds.size.height);
    }];
    
 
}

- (void)cancel
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    
}

#pragma mark --UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
