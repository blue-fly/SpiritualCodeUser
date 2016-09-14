//
//  SendFeedbackViewController.m
//  SpiritualCodeUser
//
//  Created by 段登志 on 16/9/9.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "SendFeedbackViewController.h"
#import "UIViewController+HUD.h"
#import <IQKeyboardReturnKeyHandler.h>
#import "UIControl+ActionBlocks.h"

@interface SendFeedbackViewController ()<UITextViewDelegate>

@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation SendFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    self.view.backgroundColor = [UIColor colorWithRed:0.24 green:0.75 blue:0.82 alpha:1.00];
    self.navigationController.navigationBarHidden = YES;
}


-(void)setupBasic {
//    [self setupForDismissKeyboard];
    
    // 自定义导航栏左侧按钮
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 7, 30, 30);
    //    leftBtn.backgroundColor = [UIColor orangeColor];
    [leftBtn setImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateNormal];
    //返回点击事件
    [leftBtn handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    
    self.title = @"反馈";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendFeedBack)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    UITextView *textView = [[UITextView alloc] init];
    self.textView = textView;
    CGFloat margin = 20;
    textView.frame = CGRectMake(margin, 64 + margin, [UIScreen mainScreen].bounds.size.width - 2*margin, [UIScreen mainScreen].bounds.size.height - 2*margin - CGRectGetMaxY(self.navigationController.navigationBar.frame));
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:18];
    [textView becomeFirstResponder];
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    textView.layer.cornerRadius = 5;
    textView.layer.masksToBounds = YES;
    [self.view addSubview:textView];
    
    
    UILabel *placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel = placeholderLabel;
    placeholderLabel.text = [NSString stringWithFormat:@"请输入反馈,我们将为您不断改进"];
    placeholderLabel.textColor = [UIColor grayColor];
    placeholderLabel.frame = CGRectMake(textView.frame.origin.x + 10, textView.frame.origin.y + 10, textView.frame.size.width - 20, 20);
    [self.view addSubview:placeholderLabel];
    
//    CGFloat buttonWidth = 30;
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - buttonWidth - 10, 5, buttonWidth, buttonWidth);
//    [button addTarget:self action:@selector(dissmissKeyboard) forControlEvents:UIControlEventTouchUpInside];
//    [button setBackgroundImage:[UIImage imageNamed:@"KBSkinToolbar_icon_hide"] forState:UIControlStateNormal];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
//    view.backgroundColor = [UIColor whiteColor];
//    [view addSubview:button];
//    textView.inputAccessoryView = view;
}

-(void)sendFeedBack {
    [self showHint:@"发送成功" yOffset:30.0];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)textViewDidChange:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        self.placeholderLabel.hidden = NO;
    } else {
        self.placeholderLabel.hidden = YES;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
}

@end
