//
//  InvitationViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/7/25.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "InvitationViewController.h"
#import "LXSegmentScrollView.h"
@interface InvitationViewController ()<pioneer_navigationControllerDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView *bigImageView;
@property (strong, nonatomic) UILabel *hintLB;
@property (strong, nonatomic) LXSegmentScrollView *bottomView;
@end

@implementation InvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLB.text = @"帖子";
    self.barButtonType = PioneerBarButtonTypeBack;
    self.pioneerDelegate = self;
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.bigImageView];
    [self.bottomView addSubview:self.hintLB];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _bottomView.sd_layout.topSpaceToView(self.view, 64).leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
    
    _bigImageView.sd_layout.centerXEqualToView(self.bottomView).centerYEqualToView(self.bottomView).widthIs(203).heightIs(203);
    _hintLB.sd_layout.topSpaceToView(_bigImageView, 36).centerXEqualToView(self.view).widthRatioToView(self.view,0.8).heightIs(22);
    
}

- (LXSegmentScrollView *)bottomView {
    
    if (!_bottomView) {
        _bottomView = [[LXSegmentScrollView alloc]initWithFrame:CGRectZero titleArray:@[@"我发布的",@"我评论的"] contentViewArray:nil];
        
    }
    return _bottomView;
}


- (UILabel *)hintLB {
    if (!_hintLB) {
        self.hintLB = [UILabel new];
        _hintLB.text = @"您还没发过帖子";
        _hintLB.font = [UIFont systemFontOfSize:20];
        _hintLB.textColor = UIColorFromRGB(0xb3b3b3);
        _hintLB.textAlignment = NSTextAlignmentCenter;
        
    }
    return _hintLB;
}

- (UIImageView *)bigImageView {
    if (!_bigImageView) {
        self.bigImageView = [UIImageView new];
        _bigImageView.image = [UIImage imageNamed:@"wodetiezi"];
        
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
