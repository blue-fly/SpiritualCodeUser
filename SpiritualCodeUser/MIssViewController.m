//
//  MIssViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/25.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "MIssViewController.h"
#import "SetPawViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSString+Utils.h"
#import <UIViewController+HUD.h>

@interface MIssViewController ()<pioneer_navigationControllerDelegate>
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
@property (strong, nonatomic) NSTimer *countTimer;       //计时器
@end

@implementation MIssViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupForDismissKeyboard];
    self.barButtonType = PioneerBarButtonTypeBack;
    self.pioneerDelegate = self;

    self.titleLB.text = @"找回密码";
    NSLog(@"aaaaa");

    [self.view addSubview:self.settingImage];
    [self.settingImage addSubview:self.usernameLB];
    [self.settingImage addSubview:self.verifyCodeLB];
    [self.settingImage addSubview:self.seperateLineTwo];
     [self.settingImage addSubview:self.separateLine];
    [self.settingImage addSubview:self.usernameTF];
    [self.settingImage addSubview:self.verifyCodeTF];
    [self.settingImage addSubview:self.verifyBtn];
    [self.settingImage addSubview:self.confirmBtn];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _settingImage.sd_layout.topSpaceToView(self.view,64).leftEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(self.view, 0);
    
    _usernameLB.sd_layout.topSpaceToView(self.settingImage, 64).leftSpaceToView (self.settingImage,20).heightIs(30).widthIs(60);
    _usernameTF.sd_layout.topEqualToView(self.usernameLB).leftSpaceToView(self.usernameLB,10).heightIs(30).widthRatioToView(self.settingImage,0.7);
    _separateLine.sd_layout.topSpaceToView(self.usernameLB,3).leftSpaceToView(self.settingImage,5).rightSpaceToView(self.settingImage, 5).heightIs(1);
    
    
    _verifyCodeLB.sd_layout.topSpaceToView(self.usernameLB,30).leftEqualToView(self.usernameLB).widthIs(60).heightIs(30);
    _verifyCodeTF.sd_layout.topEqualToView(self.verifyCodeLB).leftSpaceToView(self.verifyCodeLB, 10).widthRatioToView(self.settingImage,0.6).heightIs(30);
    _seperateLineTwo.sd_layout.topSpaceToView(self.verifyCodeLB,3).leftSpaceToView(self.settingImage,5).widthRatioToView(self.settingImage,0.7).heightIs(1);
    _verifyBtn.sd_layout.topEqualToView(self.verifyCodeLB).rightSpaceToView(self.settingImage,5).heightIs(35).widthIs(100);
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
        _usernameLB.text = @"手机号";
        //        _usernameLB.backgroundColor = [UIColor redColor];
        _usernameLB.textAlignment = NSTextAlignmentCenter;
    }
    
    return _usernameLB;
}
-(UITextField *)usernameTF
{
    if(!_usernameTF){
        _usernameTF = [UITextField new];
        _usernameTF.placeholder = @"请输入手机号";
        //        _usernameTF.backgroundColor = [UIColor cyanColor];
        _usernameTF.font = [UIFont systemFontOfSize:20];
        _usernameTF.keyboardType = UIKeyboardTypeNumberPad;
        
    }
    return _usernameTF;
}



- (UILabel *)verifyCodeLB {
    if (!_verifyCodeLB) {
        self.verifyCodeLB = [UILabel new];
        _verifyCodeLB.text = @"验证码";
        
        _verifyCodeLB.textAlignment = NSTextAlignmentCenter;
    }
    
    return _verifyCodeLB;
}

-(UITextField *)verifyCodeTF
{
    if(!_verifyCodeTF){
        _verifyCodeTF = [UITextField new];
        _verifyCodeTF.placeholder = @"验证码";
        _verifyCodeTF.font = [UIFont systemFontOfSize:20];
        _verifyCodeTF.keyboardType = UIKeyboardTypeNumberPad;
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
-(UIButton *)verifyBtn {
    if(!_verifyBtn){
        _verifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        //        [_verifyBtn setBackgroundImage:[UIColorFromRGB(0xFFFFFF)createImageWithColor]  forState:UIControlStateNormal];
        //        UIColor *disableColor = [UIColor whiteColor];
        
        //        [_verifyBtn setBackgroundImage:[disableColor createImageWithColor]  forState:UIControlStateDisabled];
        
//        [_verifyBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
//        _verifyBtn.sd_cornerRadius = @5;
        
        _verifyBtn.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        [_verifyBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        _verifyBtn.sd_cornerRadius = @5;
        
        @weakify(self);
        [[_verifyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
            @strongify(self);
            [self.view endEditing:YES];
            NSString *tel = self.usernameTF.text;
            if ([tel checkTelNumber]) {
                
                //获取短信验证码
                [[HTTPManager sharedHTTPManager] httpManager:[NSString stringWithFormat:@"http://121.42.165.80/reg/sms/smsCode/?phone=%@",tel] parameter:nil requestType:HTTPTypePost complectionBlock:^(id responseData, NSError *error) {
                    //启动定时器
                    [self countTimer];
                    sender.enabled = NO;
                    NSString *resultMessage = nil;
                    if (!error) {
                        resultMessage = @"验证码已发送";
                    }
                    else
                    {
                        resultMessage = @"获取验证码失败";
                    }
                    [self performSelectorOnMainThread:@selector(showResultInfo:) withObject:resultMessage waitUntilDone:YES];
                }];
                return ;
            }
            [self performSelectorOnMainThread:@selector(showResultInfo:) withObject:@"请输入正确的手机号码" waitUntilDone:YES];
        }];
        
        
    }
    return _verifyBtn;

}

- (void)showResultInfo:(NSString *)resultMessage
{
    [self showHint:resultMessage yOffset:50];
}

-(NSTimer *)countTimer
{
    if(!_countTimer){
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(verifyCountTimer:) userInfo:nil repeats:YES];
    }
    return _countTimer;
}
//计时方法
- (void)verifyCountTimer:(NSTimer *)timer
{
    static int count = 60;
    count--;
    if (count <= 0) {
        if ([_countTimer isValid]) {
            [self.countTimer invalidate];
            _countTimer = nil;
        }
        count = 60;
        [self.verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.verifyBtn.enabled = YES;
        return;
    }
    [self.verifyBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
}

-(UIButton *)confirmBtn
{
    if(!_confirmBtn){
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"验证" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font    = [UIFont systemFontOfSize: 25];

        _confirmBtn.backgroundColor = UIColorFromRGB(0x3ebed2);
//        [_confirmBtn addTarget:self action:@selector(conAction:) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.sd_cornerRadius = @5;
        @weakify(self);
        [[_confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self.view endEditing:YES];
            
            [[HTTPManager sharedHTTPManager] httpManager:[NSString stringWithFormat:@"http://121.42.165.80/reg/sms/chkCode/?phone=%@&smsCode=%@", _usernameTF.text, _verifyCodeTF.text] parameter:nil requestType:HTTPTypePost complectionBlock:^(NSDictionary * responseData, NSError *error) {
                
                if (!error) {
    

                    if ([responseData[@"code"]  isEqualToString:@"1000020"]) {
                        
                        //验证码错误
                        [self showHint:@"验证码错误" yOffset:50];
                        
                    }else if([responseData[@"code"]  isEqualToString:@"1000000"]) {
                        
                        //验证成功
                        
                        //将当前手机号与验证码进行存储，用于后面的密码修改
                        [[NSUserDefaults standardUserDefaults] setObject:_usernameTF.text forKey:@"UserPhone"];
                        [[NSUserDefaults standardUserDefaults] setObject:_verifyCodeTF.text forKey:@"UserCode"];
                        
                        //同步
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        
                        [self conAction];
                        
                    }else {
                        
                        //其他问题
                        [self showHint:@"后台问题，请稍后再试" yOffset:50];
                        
                    }
                    
                    
                    
                }else {
                    
                    //错误的验证码
                    [self showHint:@"数据紊乱" yOffset:50];
                    
                }
                
            }];


        }];
    }
    return _confirmBtn;
}

- (void)conAction {
    
    SetPawViewController *setVC = [SetPawViewController new];
    [self.navigationController pushViewController:setVC animated:YES];
    
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
