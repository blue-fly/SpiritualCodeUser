//
//  pioneer_navigationController.m
//  SpiritualCode
//
//  Created by pioneer on 16/6/26.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "pioneer_navigationController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
@interface pioneer_navigationController ()
@property (strong, nonatomic) UIButton *notifyButton;
@property (strong, nonatomic) UIView *statusBgView;      //状态条背景条

@end

@implementation pioneer_navigationController
//方法需要重写

- (void)loadView
{
    self.view =  [[UIView alloc]initWithFrame:kContent_Frame];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.pioneer_navBar];
    [self.pioneer_navBar addSubview:self.notifyButton];
    
    
    [self.view addSubview:self.topView];
    
//    [self.view addSubview:self.statusBgView];
    
}
#pragma mark 懒加载




- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor colorWithRed:0.00 green:0.77 blue:0.84 alpha:1.00];
//        _topView.backgroundColor = UIColorFromRGB(0x3ebed2);
        
    }
    return _topView;
}

-(UIView *)pioneer_navBar
{
    if(!_pioneer_navBar){
        _pioneer_navBar = [UIView new];
//        if (_pioneer_navBar.tag == 001) {
             _pioneer_navBar.backgroundColor = [UIColor colorWithRed:0.00 green:0.77 blue:0.84 alpha:1.00];
//        }else {
//            _pioneer_navBar.backgroundColor = [UIColor whiteColor];
//        }
       
    }
    return _pioneer_navBar;
}


    


-(UILabel *)titleLB
{
    if(!_titleLB){
        _titleLB = [UILabel new];
        _titleLB.textAlignment = NSTextAlignmentCenter;
        _titleLB.textColor = [UIColor whiteColor];
        [_pioneer_navBar addSubview:_titleLB];
        _titleLB.sd_layout.topSpaceToView(_pioneer_navBar,10).leftSpaceToView(_pioneer_navBar,30).rightSpaceToView(_pioneer_navBar,30).bottomSpaceToView(_pioneer_navBar,10);
    }
    return _titleLB;
}
-(UIButton *)notifyButton
{
    if(!_notifyButton){
        _notifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_notifyButton setTitle:@"" forState:UIControlStateNormal];
        _notifyButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
//        _notifyButton.backgroundColor = [UIColor grayColor];
        @weakify(self);
        [[_notifyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            if (self.pioneerDelegate) {
                if ([self.pioneerDelegate respondsToSelector:@selector(pioneer_navigationController:withPioneerBarButtonType:)]) {
                    [self.pioneerDelegate pioneer_navigationController:self withPioneerBarButtonType:self.barButtonType];
                }
            }
        }];
    }
    return _notifyButton;
}
-(UIView *)statusBgView
{
    if(!_statusBgView){
        _statusBgView = [UIView new];
        _statusBgView.backgroundColor = UIColorFromRGB(0x3ebed2);
    }
    return _statusBgView;
}
// 通过按钮 设置界面展示
- (void)setBarButtonType:(PioneerBarButtonType)barButtonType
{
    _barButtonType = barButtonType;
    NSString *btnImageName =  nil;
    switch (barButtonType) {
        case PioneerBarButtonTypeNotify:
        {
            btnImageName = @"bar_notice";
            
        }
            break;
        case PioneerBarButtonTypeBack:
        {
            btnImageName = @"fanhuibai";
            
        }
            break;
        case PioneerBarButtonTypeModel:
        {
            btnImageName = @"bar_x";
            
        }
            break;
        case PioneerBarButtonTypeSearch:
        {
            //搜索
        }
            break;
//        case PioneerBarButtonTypeLogin:
//        {
////            //注册
//            
//        }
        case PioneerBarButtonTypeHidden:
        {
            //隐藏
            self.notifyButton.hidden = YES;
        }
            break;
        default:
            break;
    }
    [_notifyButton setImage:[UIImage imageNamed:btnImageName] forState:UIControlStateNormal];
}
#pragma mark 自动布局
- (void)viewWillLayoutSubviews
{
    _pioneer_navBar.sd_layout.topSpaceToView(self.view,20).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(44);
    _notifyButton.sd_layout.topSpaceToView(self.pioneer_navBar,5).leftSpaceToView(self.pioneer_navBar,10).bottomSpaceToView(self.pioneer_navBar,5).widthEqualToHeight();
//    _statusBgView.sd_layout.topSpaceToView(self.view,0).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(20);
    
   _topView.sd_layout.topEqualToView(self.view).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(20);
}
#pragma mark ------设定状态条背景颜色--------
- (void)setStatusHidden:(BOOL)isHidden;
{
    self.statusBgView.hidden = isHidden;
}
#pragma mark 协议
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
