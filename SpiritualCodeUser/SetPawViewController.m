//
//  SetPawViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/25.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "SetPawViewController.h"
#import <AFNetworking.h>
#import "UIViewController+HUD.h"

@interface SetPawViewController ()<pioneer_navigationControllerDelegate>
@property (strong, nonatomic) UILabel *verifyCodeLB; //  验证码
@property (strong, nonatomic) UITextField *verifyCodeTF;          //验证码
@property (strong, nonatomic) UILabel *usernameLB; //用户名
@property (strong, nonatomic) UITextField *usernameTF;     //用户名
@property (strong, nonatomic) UIImageView *userNameIcon;   //用户名图标
@property (strong, nonatomic) UIButton *verifyBtn;       //获取验证码按钮
@property (strong, nonatomic) UIImageView *settingImage;  //背景
@property (strong, nonatomic) UIView *separateLine;        //分隔线
@property (strong, nonatomic) UIView *seperateLineTwo;   //分隔线二
@property (strong, nonatomic) UIButton *confirmBtn;
@end

@implementation SetPawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupForDismissKeyboard];
    self.barButtonType = PioneerBarButtonTypeBack;
    self.pioneerDelegate = self;
    
    self.titleLB.text = @"找回密码";
    
    
    [self.view addSubview:self.settingImage];
    [self.settingImage addSubview:self.usernameLB];
    [self.settingImage addSubview:self.verifyCodeLB];
    [self.settingImage addSubview:self.seperateLineTwo];
    [self.settingImage addSubview:self.separateLine];
    [self.settingImage addSubview:self.usernameTF];
    [self.settingImage addSubview:self.verifyCodeTF];
    [self.settingImage addSubview:self.verifyBtn];
    [self.settingImage addSubview:self.confirmBtn];

}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _settingImage.sd_layout.topSpaceToView(self.view,64).leftEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(self.view, 0);
    
    _usernameLB.sd_layout.topSpaceToView(self.settingImage, 64).leftSpaceToView (self.settingImage,20).heightIs(30).widthIs(80);
    _usernameTF.sd_layout.topEqualToView(self.usernameLB).leftSpaceToView(self.usernameLB,10).heightIs(30).widthRatioToView(self.settingImage,0.7);
    _separateLine.sd_layout.topSpaceToView(self.usernameLB,3).leftSpaceToView(self.settingImage,10).rightSpaceToView(self.settingImage, 5).heightIs(1);
    
    
    _verifyCodeLB.sd_layout.topSpaceToView(self.usernameLB,30).leftEqualToView(self.usernameLB).widthIs(80).heightIs(30);
    _verifyCodeTF.sd_layout.topEqualToView(self.verifyCodeLB).leftSpaceToView(self.verifyCodeLB, 10).rightSpaceToView(self.settingImage,5).heightIs(30);
    _seperateLineTwo.sd_layout.topSpaceToView(self.verifyCodeLB,3).leftSpaceToView(self.settingImage,10).rightSpaceToView(self.settingImage,5).heightIs(1);
    
    _confirmBtn.sd_layout.topSpaceToView(self.seperateLineTwo,60).heightRatioToView(self.settingImage,0.07).widthRatioToView(self.settingImage,0.8).centerXEqualToView(self.settingImage);

   
}

- (UIImageView *)settingImage {
    if (!_settingImage) {
        self.settingImage = [[UIImageView alloc] init];
        _settingImage.image = [UIImage imageNamed:@"Azhucebeijing"];
        
        
        _settingImage.contentMode = UIViewContentModeScaleAspectFill;
        _settingImage.userInteractionEnabled = YES;
        
    }
    
    return _settingImage;
}

- (UILabel *)usernameLB {
    if (!_usernameLB) {
        self.usernameLB = [[UILabel alloc] init];
        _usernameLB.text = @"密码";
        //        _usernameLB.backgroundColor = [UIColor redColor];
        _usernameLB.textAlignment = NSTextAlignmentCenter;
    }
    
    return _usernameLB;
}
-(UITextField *)usernameTF
{
    if(!_usernameTF){
        _usernameTF = [UITextField new];
        _usernameTF.placeholder = @"请输入密码";
        //        _usernameTF.backgroundColor = [UIColor cyanColor];
        _usernameTF.font = [UIFont systemFontOfSize:20];
        _usernameTF.keyboardType = UIKeyboardTypeNumberPad;
        [_usernameTF setSecureTextEntry:YES];
        
    }
    return _usernameTF;
}



- (UILabel *)verifyCodeLB {
    if (!_verifyCodeLB) {
        self.verifyCodeLB = [UILabel new];
        _verifyCodeLB.text = @"确认密码";
        _verifyCodeLB.textAlignment = NSTextAlignmentCenter;
    }
    
    return _verifyCodeLB;
}

-(UITextField *)verifyCodeTF
{
    if(!_verifyCodeTF){
        _verifyCodeTF = [UITextField new];
        _verifyCodeTF.placeholder = @"确认密码";
        _verifyCodeTF.font = [UIFont systemFontOfSize:20];
        _verifyCodeTF.keyboardType = UIKeyboardTypeNumberPad;
        [_verifyCodeTF setSecureTextEntry:YES];
    }
    return _verifyCodeTF;
}

-(UIView *)separateLine
{
    if(!_separateLine){
        _separateLine = [UIView new];
        _separateLine.backgroundColor = [UIColor grayColor];
    }
    return _separateLine;
}

-(UIView *)seperateLineTwo
{
    if(!_seperateLineTwo){
        _seperateLineTwo = [UIView new];
        _seperateLineTwo.backgroundColor = [UIColor grayColor];;
    }
    return _seperateLineTwo;
}

-(UIButton *)confirmBtn
{
    if(!_confirmBtn){
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font    = [UIFont systemFontOfSize: 25];
        
        [_confirmBtn addTarget:self action:@selector(updatePwd) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.backgroundColor = UIColorFromRGB(0x3ebed2);
        _confirmBtn.sd_cornerRadius = @5;
        
    }
    return _confirmBtn;
}

//修改密码
- (void)updatePwd {
    
    //先判断两次输入的是否一致
    if (![_verifyCodeTF.text isEqualToString:_usernameTF.text]) {
        //不一致，提示加返回
        [self showHint:@"两次密码输入不一致" yOffset:50];
        return;
    }
    
    
    //将之前存储的手机号与验证码取出
    NSString *phone = [[NSUserDefaults standardUserDefaults] stringForKey:@"UserPhone"];
    
    NSString *smsCode = [[NSUserDefaults standardUserDefaults] stringForKey:@"UserCode"];
    
    
    //应该进行一次封装的，但是先这样吧
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //网络传输类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://121.42.165.80/a/noauth/user/modifyPwd" parameters:@{@"phone":phone,@"smsCode":smsCode,@"newPassword":_verifyCodeTF.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  responseObject) {
        
        NSLog(@"%@",responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self showHint:@"密码修改出错，请稍后再试！" yOffset:50];
        
    }];

    
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
