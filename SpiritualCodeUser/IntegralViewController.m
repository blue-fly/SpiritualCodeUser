//
//  IntegralViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/7/26.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "IntegralViewController.h"

@interface IntegralViewController ()<pioneer_navigationControllerDelegate>

@end

@implementation IntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLB.text = @"积分";
    self.barButtonType = PioneerBarButtonTypeBack;
    self.pioneerDelegate = self;
    // Do any additional setup after loading the view.
}




- (void)pioneer_navigationController:(pioneer_navigationController *)navigationController withPioneerBarButtonType:(PioneerBarButtonType)barButtonType {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
