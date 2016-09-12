//
//  MyLocationViewController.m
//  SpiritualCodeUser
//
//  Created by 段登志 on 16/9/6.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "MyLocationViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface MyLocationViewController ()

@end

@implementation MyLocationViewController

- (void)loadView {
    
    self.view =  [[UIView alloc]initWithFrame:kContent_Frame];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title = @"定位";
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.250 green:0.327 blue:1.000 alpha:0.724];
    
    
}

#pragma mark - EaseMessageCellDelegate



@end
