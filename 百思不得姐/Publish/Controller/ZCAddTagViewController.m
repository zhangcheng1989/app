//
//  ZCAddTagViewController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/24.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCAddTagViewController.h"
#import "ZCTagButton.h"
#import "ZCTagTextField.h"
#import "SVProgressHUD.h"
@interface ZCAddTagViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) ZCTagTextField *textField;
@property (nonatomic, weak) UIButton *addbutton;
@property (nonatomic, strong) NSMutableArray *tagButtons;
@end

@implementation ZCAddTagViewController

- (UIButton *)addbutton{
    if (!_addbutton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.width = self.contentView.width;
        addButton.height = 30;
        addButton.backgroundColor = ZCColor(74, 139, 209);
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, tagMargin, 0, tagMargin);
        //让按钮的图片和文字左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addButton];
        _addbutton = addButton;
    }
    return _addbutton;
}

- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpContentView];
    
    [self setUpTextField];
    
    [self setUpTags];
}


- (void)setUpNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

- (void)setUpContentView
{
    self.contentView = [[UIView alloc]init];
    self.contentView.x  = TopicCellMargin;
    self.contentView.width = self.view.width - 2 * self.contentView.x;
    self.contentView.y = 64+TopicCellMargin;
    self.contentView.height = [UIScreen mainScreen].bounds.size.height;
    [self.view addSubview:self.contentView];
}

- (void)setUpTextField
{
    
    __weak typeof(self) weakSelf = self;
    self.textField = [[ZCTagTextField alloc]init];
    self.textField.width = self.contentView.width;
    self.textField.deleteBlock = ^{
        if (weakSelf.textField.hasText) return ;
        [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
    };

    [self.textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    self.textField.delegate = self;
    [self.textField becomeFirstResponder];
    [self.contentView addSubview:self.textField];
}


- (void)setUpTags
{
    for (NSString *tag in self.tags) {
        self.textField.text = tag;
        [self addButtonClick];
    }
}

- (void)done
{
//    NSMutableArray *tags = [NSMutableArray array];
//    for (ZCTagButton *tagButton in self.tagButtons) {
//        [tags addObject:tagButton.currentTitle];
//    }
    
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.tagBlock?:self.tagBlock(tags);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textDidChange
{
    [self updateTextFieldFrame];
    
    if (self.textField.hasText) {
        self.addbutton.hidden = NO;
        self.addbutton.y = CGRectGetMaxY(self.textField.frame)+tagMargin;
        [self.addbutton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textField.text] forState:UIControlStateNormal];
        
        NSString *lastlatter = [self.textField.text substringFromIndex:self.textField.text.length-1];
        if ([lastlatter isEqualToString:@","] || [lastlatter isEqualToString:@"，"]) {
            self.textField.text  = [self.textField.text substringToIndex:self.textField.text.length - 1];
            [self addButtonClick];
        }
    }else{
        self.addbutton.hidden = YES;
    }
    
}

- (void)addButtonClick
{
 
    if (self.tagButtons.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多输入5个标签"];
        return;
    }
    ZCTagButton *tagButton = [ZCTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    tagButton.height = self.textField.height;
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    
    self.textField.text = nil;
    self.addbutton.hidden = YES;
    
    //更新标签按钮的frame
    [self updateTagButtonFrame];
    [self updateTextFieldFrame];

    
}

- (void)updateTagButtonFrame
{
    //更新标签按钮的frame
    for (NSInteger i =0; i<self.tagButtons.count; i++) {
        ZCTagButton *tagButton = self.tagButtons[i];
        if (i == 0) {// 最前面的标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
        }else{ //其他标签按钮
            UIButton *lastTagButton = self.tagButtons[i-1];
            CGFloat leftWith = CGRectGetMaxX(lastTagButton.frame)+tagMargin; //计算当前行左边宽度
            CGFloat rightWith = self.contentView.width - leftWith; //计算当前行右边宽度
            if (rightWith >= tagButton.width) { //标签按钮显示在当前航
                tagButton.y = lastTagButton.y;
                tagButton.x = leftWith;
            }else{
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame)+tagMargin;
            }
        }
    }
    
   
    
}


- (void)updateTextFieldFrame
{
    ZCTagButton *lastButton = [self.tagButtons lastObject];
    CGFloat leftWith = CGRectGetMaxX(lastButton.frame) + tagMargin;
    //更新textFieldframe
    if (self.contentView.width - leftWith >= [self textFieldTextWith]) {
        self.textField.x = leftWith;
        self.textField.y = lastButton.y;
    }else{
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastButton.frame)+tagMargin;
    }
    
    self.addbutton.y = CGRectGetMaxY(self.textField.frame) + tagMargin;
}

- (void)tagButtonClick:(ZCTagButton *)tagBtn
{
    [tagBtn removeFromSuperview];
    [self.tagButtons removeObject:tagBtn];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
    }];
}


- (CGFloat)textFieldTextWith
{
    CGFloat textW =  [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
    return MAX(100, textW);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}

@end
