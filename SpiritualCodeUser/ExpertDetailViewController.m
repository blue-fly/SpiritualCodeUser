//
//  ExpertDetailViewController.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/10.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ExpertDetailViewController.h"
#import "ExpertCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <EaseUI.h>
#import "TalkViewController.h"
@interface ExpertDetailViewController ()<pioneer_navigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) ExpertModel *expertData;
@property (strong, nonatomic) UITableView *expertDetailTB;    //主体表格
@property (strong, nonatomic) UIView *bottomContentView;      //底部视图
@property (strong, nonatomic) UIButton *communicateBtn;       //沟通按钮
@end

@implementation ExpertDetailViewController
- (instancetype)initWithExpert:(ExpertModel *)expert
{
    if (self = [super init]) {
        _expertData = expert;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLB.text = @"专家信息";
    self.barButtonType = PioneerBarButtonTypeBack;
    self.pioneerDelegate = self;
    [self.view addSubview:self.expertDetailTB];
    [self.view addSubview:self.bottomContentView];
    [self.view addSubview:self.communicateBtn];
}
#pragma mark --------------自动布局----------
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _expertDetailTB.sd_layout.spaceToSuperView(UIEdgeInsetsMake(64, 0, 0, 0));
    _bottomContentView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).heightIs(50);
    _communicateBtn.sd_layout.centerXEqualToView(_bottomContentView).centerYEqualToView(_bottomContentView).widthRatioToView(_bottomContentView,0.6).heightRatioToView(_bottomContentView,0.8);
    _communicateBtn.sd_cornerRadius = @5;
}
#pragma mark ---------------懒加载-----------

-(UITableView *)expertDetailTB
{
    if(!_expertDetailTB){
        _expertDetailTB = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _expertDetailTB.backgroundColor = MainBGColor;
        _expertDetailTB.tableFooterView = [UIView new];
        _expertDetailTB.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_expertDetailTB registerClass:[ExpertCell class] forCellReuseIdentifier:NSStringFromClass([ExpertCell class])];
        _expertDetailTB.delegate = self;
        _expertDetailTB.dataSource = self;
    }
    return _expertDetailTB;
}
-(UIButton *)communicateBtn
{
    if(!_communicateBtn){
        _communicateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_communicateBtn setTitle:@"专家咨询" forState:UIControlStateNormal];
        _communicateBtn.backgroundColor = MainGreenColor;
        @weakify(self);
        [[_communicateBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            TalkViewController *vc = [[TalkViewController alloc]initWithConversationChatter:self.expertData.userID conversationType:eConversationTypeChat];
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
    }
    return _communicateBtn;
}
-(UIView *)bottomContentView
{
    if(!_bottomContentView){
        _bottomContentView = [UIView new];
        _bottomContentView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomContentView;
}
#pragma mark ---------------协议------------
- (void)pioneer_navigationController:(pioneer_navigationController *)navigationController withPioneerBarButtonType:(PioneerBarButtonType) barButtonType
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpertCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ExpertCell class]) forIndexPath:indexPath];
    [cell setDataWithModel:_expertData];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 150;
    }
    return 50;
}
@end
