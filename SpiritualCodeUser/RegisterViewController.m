//
//  RegisterViewController.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/9.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "RegisterViewController.h"
#import <IQKeyboardReturnKeyHandler.h>
#import "UIColor+Image.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "NSString+Utils.h"
#import <SMS_SDK/SMSSDK.h>
#import <UIViewController+HUD.h>
#import <EaseMob.h>
#import "NSObject+EaseMobAddDelegate.h"

#define RegisterBgColor [UIColor colorWithRed:232.0/255 green:232.0/255 blue:232.0/255 alpha:1]
@interface RegisterViewController ()<pioneer_navigationControllerDelegate>
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;//键盘管理器
@property (strong, nonatomic) UIView *register_contentView;//登录面板
@property (strong, nonatomic) UILabel *usernameLB; //

@property (assign, nonatomic) BOOL isYes;


@property (strong, nonatomic) UILabel *verifyCodeLB; //  验证码
@property (strong, nonatomic) UITextField *verifyCodeTF;          //验证码

@property (strong, nonatomic) UITextField *usernameTF;     //用户名
@property (strong, nonatomic) UIImageView *userNameIcon;   //用户名图标
@property (strong, nonatomic) UIButton *verifyBtn;       //获取验证码按钮

@property (strong, nonatomic) UILabel *pswLB; //
@property (strong, nonatomic) UITextField *pswTF;        //密码

@property (strong, nonatomic) UIImageView *verifyCodeIcon;        //验证码图标

@property (strong, nonatomic) UIImageView *registerIcon; //图标

@property (strong, nonatomic) UIView *separateLine;        //分隔线
@property (strong, nonatomic) UIView *seperateLineTwo;   //分隔线二
@property (strong, nonatomic) UIView *seperateLineThree;   //分割线三
@property (strong, nonatomic) UIButton *confirmBtn;      //注册
@property (strong, nonatomic) NSTimer *countTimer;       //计时器

@property (strong, nonatomic) UIImageView *settingImage;  //背景
@end

@implementation RegisterViewController

- (void)loadView
{
    self.view =  [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = RegisterBgColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self registerEaseMobNotification];
    self.titleLB.text = @"注册账号";
    self.barButtonType = PioneerBarButtonTypeBack;
    self.pioneerDelegate = self;
    
    
    [self.view addSubview:self.register_contentView];
    
    [self.view addSubview:self.settingImage];
    
    [self.settingImage addSubview:self.usernameLB];
    [self.settingImage addSubview:self.separateLine];
    
    [self.settingImage addSubview:self.verifyCodeLB];
    [self.settingImage addSubview:self.seperateLineTwo];
    [self.settingImage addSubview:self.pswLB];
    [self.settingImage addSubview:self.seperateLineThree];
    [self.settingImage addSubview:self.usernameTF];
    [self.settingImage addSubview:self.verifyCodeTF];
    [self.settingImage addSubview:self.pswTF];
    
    [self.settingImage addSubview:self.verifyBtn];
    [self.settingImage addSubview:self.confirmBtn];
    
    
    //    [self.register_contentView addSubview:self.userNameIcon];
    //
    //    [self.register_contentView addSubview:self.separateLine];
    //
    //    [self.register_contentView addSubview:self.verifyCodeIcon];
    //    [self.register_contentView addSubview:self.verifyCodeTF];
    //    [self.verifyCodeTF addSubview:self.verifyBtn];
    //    [self.register_contentView addSubview:self.seperateLineTwo];
    //    [self.register_contentView addSubview:self.registerIcon];
    //    [self.register_contentView addSubview:self.pswTF];
    //    [self.view addSubview:self.confirmBtn];
    
    
    //    [self register_signal];
}
#pragma mark 自动布局
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _settingImage.sd_layout.topSpaceToView(self.view,64).leftEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(self.view, 0);
    
    _usernameLB.sd_layout.topSpaceToView(self.settingImage, 64).leftSpaceToView (self.settingImage,20).heightIs(30).widthIs(60);
    _usernameTF.sd_layout.topEqualToView(self.usernameLB).leftSpaceToView(self.usernameLB,10).heightIs(30).widthRatioToView(self.settingImage,0.7);
    _separateLine.sd_layout.topSpaceToView(self.usernameLB,3).leftSpaceToView(self.settingImage,5).rightSpaceToView(self.settingImage, 5).heightIs(1);
    
    
    _verifyCodeLB.sd_layout.topSpaceToView(self.usernameLB,30).leftEqualToView(self.usernameLB).widthIs(60).heightIs(30);
    _verifyCodeTF.sd_layout.topEqualToView(self.verifyCodeLB).leftSpaceToView(self.verifyCodeLB, 10).widthRatioToView(self.settingImage,0.6).heightIs(30);
    _seperateLineTwo.sd_layout.topSpaceToView(self.verifyCodeLB,3).leftSpaceToView(self.settingImage,5).widthRatioToView(self.settingImage,0.7).heightIs(1);
    _verifyBtn.sd_layout.topEqualToView(self.verifyCodeLB).rightSpaceToView(self.settingImage,5).heightIs(35).widthIs(100);
    
    
    
    _pswLB.sd_layout.topSpaceToView(self.verifyCodeLB,30).leftEqualToView(self.usernameLB).widthIs(60).heightIs(30);
    _pswTF.sd_layout.topEqualToView(self.pswLB).leftSpaceToView(self.pswLB,10).widthRatioToView(self.settingImage,0.7).heightIs(30);
    _seperateLineThree.sd_layout.topSpaceToView(self.pswLB,3).leftSpaceToView(self.settingImage,5).rightSpaceToView(self.settingImage, 5).heightIs(1);
    
    _confirmBtn.sd_layout.topSpaceToView(self.pswTF,60).heightRatioToView(self.settingImage,0.07).widthRatioToView(self.settingImage,0.8).centerXEqualToView(self.settingImage);
    
    //    _pswLB.sd_layout.topSpaceToView(self.settingImage, 64).leftSpaceToView(self.settingImage, 20).heightIs(20).widthIs(40);
    
    
    //    _register_contentView.sd_layout.topSpaceToView(self.view,100).centerXEqualToView(self.view).widthRatioToView(self.view,0.8).heightIs(150);
    //    _userNameIcon.sd_layout.topSpaceToView(_register_contentView,15).leftSpaceToView(_register_contentView,10).heightIs(25).widthEqualToHeight();
    //    _usernameTF.sd_layout.topSpaceToView(_register_contentView,10).leftSpaceToView(_userNameIcon,5).rightEqualToView(_register_contentView).heightIs(35);
    //    _separateLine.sd_layout.topSpaceToView(_usernameTF,3).leftSpaceToView(_register_contentView,10).rightSpaceToView(_register_contentView,10).heightIs(1);
    //    _verifyCodeIcon.sd_layout.topSpaceToView(_separateLine,15).leftSpaceToView(_register_contentView,10).heightIs(25).widthEqualToHeight();
    //    _verifyCodeTF.sd_layout.topSpaceToView(_separateLine,10).leftSpaceToView(_verifyCodeIcon,5).rightEqualToView(_register_contentView).heightIs(35);
    //    _verifyBtn.sd_layout.topSpaceToView(_verifyCodeTF,0).rightSpaceToView(_verifyCodeTF,5).bottomSpaceToView(_verifyCodeTF,0).widthIs(100);
    //    _seperateLineTwo.sd_layout.topSpaceToView(_verifyCodeTF,3).leftSpaceToView(_register_contentView,10).rightSpaceToView(_register_contentView,10).heightIs(1);
    //    _registerIcon.sd_layout.topSpaceToView(_seperateLineTwo,10).leftSpaceToView(_register_contentView,10).heightIs(25).widthEqualToHeight();
    //    _pswTF.sd_layout.topSpaceToView(_seperateLineTwo,10).leftSpaceToView(_registerIcon,5).rightEqualToView(_register_contentView).heightIs(35);
    //    _confirmBtn.sd_layout.topSpaceToView(_register_contentView,30).centerXEqualToView(self.view).widthRatioToView(self.view,0.8).heightIs(45);
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

- (UILabel *)pswLB {
    if (!_pswLB) {
        self.pswLB = [UILabel new];
        _pswLB.text = @"密码";
        _pswLB.textAlignment = NSTextAlignmentCenter;
    }
    
    return _pswLB;
}
-(UITextField *)pswTF
{
    if(!_pswTF){
        _pswTF = [UITextField new];
        _pswTF.placeholder = @"密码";
        _pswTF.font = [UIFont systemFontOfSize:20];
        _pswTF.secureTextEntry = YES;
    }
    return _pswTF;
}

//-(UIImageView *)registerIcon
//{
//    if(!_registerIcon){
//        _registerIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mima"]];
//    }
//    return _registerIcon;
//}

-(UIView *)separateLine
{
    if(!_separateLine){
        _separateLine = [UIView new];
        _separateLine.backgroundColor = [UIColor blackColor];
    }
    return _separateLine;
}

-(UIView *)seperateLineTwo
{
    if(!_seperateLineTwo){
        _seperateLineTwo = [UIView new];
        _seperateLineTwo.backgroundColor = [UIColor blackColor];;
    }
    return _seperateLineTwo;
}
-(UIView *)seperateLineThree
{
    if(!_seperateLineThree){
        _seperateLineThree = [UIView new];
        _seperateLineThree.backgroundColor = [UIColor blackColor];;
    }
    return _seperateLineThree;
}


#pragma mark 懒加载
-(UIView *)register_contentView
{
    if(!_register_contentView){
        _register_contentView = [UIView new];
        _register_contentView.backgroundColor = [UIColor whiteColor];
        _register_contentView.sd_cornerRadius = @5;
    }
    return _register_contentView;
}

//-(UIImageView *)userNameIcon
//{
//    if(!_userNameIcon){
//        _userNameIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yonghuming"]];
//    }
//    return _userNameIcon;
//}
//-(UIImageView *)verifyCodeIcon
//{
//    if(!_verifyCodeIcon){
//        _verifyCodeIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_code"]];
//    }
//    return _verifyCodeIcon;
//}
-(UIButton *)verifyBtn
{
    if(!_verifyBtn){
        _verifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        //        [_verifyBtn setBackgroundImage:[UIColorFromRGB(0xFFFFFF)createImageWithColor]  forState:UIControlStateNormal];
        //        UIColor *disableColor = [UIColor whiteColor];
        
        //        [_verifyBtn setBackgroundImage:[disableColor createImageWithColor]  forState:UIControlStateDisabled];
        
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
        [_confirmBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[UIColorFromRGB(0x3ebed2) createImageWithColor]  forState:UIControlStateNormal];
        //        UIColor *disableColor = [UIColor colorWithRed:0.9892 green:0.4132 blue:0.0318 alpha:0.4];
        //        [_confirmBtn setBackgroundImage:[disableColor createImageWithColor]  forState:UIControlStateDisabled];
        _confirmBtn.backgroundColor = UIColorFromRGB(0x3ebed2);
        _confirmBtn.sd_cornerRadius = @5;
        @weakify(self);
        [[_confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self.view endEditing:YES];
            
            [[HTTPManager sharedHTTPManager] httpManager:[NSString stringWithFormat:@"http://121.42.165.80/reg/sms/chkCode/?phone=%@&smsCode=%@", _usernameTF.text, _verifyCodeTF.text] parameter:nil requestType:HTTPTypePost complectionBlock:^(id responseData, NSError *error) {
                if (!error) {
                    //                    成功
                    //                    [[HTTPManager sharedHTTPManager] httpManager:[NSString stringWithFormat:@"http://121.42.165.80/reg/user/?loginName=%@&password=%@&name=123", _usernameTF.text,_pswTF.text] parameter:nil requestType:HTTPTypePost complectionBlock:^(id responseData, NSError *error) {
                    //
                    //                        NSString *code = responseData[@"errCode"];
                    //                        if ([code isEqualToString:@"000000"]) {
                    //                            //成功
                    //                            [self showHint:@"注册成功" yOffset:50];
                    //
                    //
                    //                            [self.navigationController popViewControllerAnimated:YES];
                    //                            return ;
                    _isYes = YES;
                    
                }
                else
                {
                    _isYes = NO;
                    //                            //失败
                    //                            [self showHint:@"注册失败" yOffset:50];
                    
                }
            }];
            
            
            [self denglu];
            
            
            //            [SMSSDK commitVerificationCode:self.verifyCodeTF.text phoneNumber:self.usernameTF.text zone:@"86" result:^(NSError *error) {
            //                if (!error) {
            //                    //成功
            //                    //用输入的用户名和密码注册
            //                    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.usernameTF.text password:self.pswTF.text];
            //                    return ;
            //                }
            //                //失败
            //                [self showHint:@"验证码错误" yOffset:50];
            //            }];
        }];
        
    }
    return _confirmBtn;
}


- (void)denglu {
    
    if (_isYes == YES) {
        [[HTTPManager sharedHTTPManager] httpManager:[NSString stringWithFormat:@"http://121.42.165.80/reg/user/?loginName=%@&password=%@&name=123", _usernameTF.text,_pswTF.text] parameter:nil requestType:HTTPTypePost complectionBlock:^(id responseData, NSError *error) {
            
            [self showHint:@"注册成功" yOffset:50];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
    }else {
        //        失败
        [self showHint:@"验证码错误" yOffset:50];
        
        
    }
    
}



#pragma mark 信号
- (void)register_signal
{
    RAC(self.confirmBtn,enabled) = [RACSignal combineLatest:@[self.usernameTF.rac_textSignal,self.verifyCodeTF.rac_textSignal,self.pswTF.rac_textSignal] reduce:^id(NSString *tel, NSString *verifyCode, NSString *psw){
        return @([tel checkTelNumber] && [verifyCode checkCertifyCode] && [psw checkPassword]);
    }];
}
#pragma mark 协议
- (void)pioneer_navigationController:(pioneer_navigationController *)navigationController withPioneerBarButtonType:(PioneerBarButtonType)barButtonType
{
    if (PioneerBarButtonTypeBack == barButtonType) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//注册新用户回调
- (void)didRegisterNewAccount:(NSString *)username
                     password:(NSString *)password
                        error:(EMError *)error
{
    if (!error) {
        //注册成功
        [PioneerHelper changLoginStatus:YES];
        //进入个人中心
        UIViewController *bottomVC = self.navigationController.viewControllers[0];
        [self.navigationController  popToViewController:bottomVC animated:YES];
        UITabBarController *mainTab = (UITabBarController *)bottomVC;
        mainTab.selectedIndex = 3;
        return;
    }
    //注册失败
    [PioneerHelper changLoginStatus:NO];
    [self showHint:@"注册失败" yOffset:50];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if ([_countTimer isValid]) {
        [_countTimer invalidate];
        _countTimer = nil;
    }
    [self unRegisterEaseMobNotification];
}
- (void)dealloc
{
    self.returnKeyHandler = nil;
    
    NSLog(@"%s",__func__);
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
