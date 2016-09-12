//
//  ShopViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/7/25.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ShopViewController.h"

@interface ShopViewController ()<pioneer_navigationControllerDelegate>
@property (strong, nonatomic) UIImageView *bigImageView;
@property (strong, nonatomic) UILabel *hintLB;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLB.text = @"购物车";
    self.barButtonType = PioneerBarButtonTypeBack;
    self.pioneerDelegate = self;
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColorFromRGB(0xf2f7f5);
    
    
    [self.view addSubview:self.bigImageView];
    [self.view addSubview:self.hintLB];

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _bigImageView.sd_layout.centerXEqualToView(self.view).centerYEqualToView(self.view).widthIs(203).heightIs(203);
    _hintLB.sd_layout.topSpaceToView(_bigImageView, 36).centerXEqualToView(self.view).widthRatioToView(self.view,0.8).heightIs(22);

}

- (UILabel *)hintLB {
    if (!_hintLB) {
        self.hintLB = [UILabel new];
        _hintLB.text = @"您的购物车空空如也";
        _hintLB.font = [UIFont systemFontOfSize:20];
        _hintLB.textColor = UIColorFromRGB(0xb3b3b3);
        _hintLB.textAlignment = NSTextAlignmentCenter;
        
    }
    return _hintLB;
}

- (UIImageView *)bigImageView {
    if (!_bigImageView) {
        self.bigImageView = [UIImageView new];
        _bigImageView.image = [UIImage imageNamed:@"dingdanrenwu"];
        
    }
    return _bigImageView;
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
