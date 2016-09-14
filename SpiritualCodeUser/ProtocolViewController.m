//
//  ProtocolViewController.m
//  SpiritualCodeUser
//
//  Created by 段登志 on 16/9/14.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ProtocolViewController.h"
#import "UIControl+ActionBlocks.h"
@interface ProtocolViewController () {
    
    UIWebView *_webVC;
}

@end

@implementation ProtocolViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

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
    
    self.title = @"相关协议";
    
    //使用webView
    
    _webVC = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view addSubview:_webVC];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Protocol" ofType:@"html"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *dataHtmlString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    _webVC.scalesPageToFit = YES;
    [_webVC loadHTMLString:dataHtmlString baseURL:[NSURL URLWithString:path]];

}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    self.view.backgroundColor = [UIColor colorWithRed:0.24 green:0.75 blue:0.82 alpha:1.00];
    self.navigationController.navigationBarHidden = YES;
}



@end
