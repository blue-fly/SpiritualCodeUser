//
//  LoginViewController.m
//  SpiritualCode
//
//  Created by pioneer on 16/6/26.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "LoginViewController.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <UIView+SDAutoLayout.h>
#import "UIColor+Image.h"
#import <IQKeyboardReturnKeyHandler.h>
#import "RegisterViewController.h"
#import "NSString+Utils.h"
#import "NSObject+EaseMobAddDelegate.h"
#import <UIViewController+HUD.h>
#import "MyViewController.h"
#import "LoginModel.h"
#import "MIssViewController.h"
//登录注册按钮颜色
#define LoginRegisterColor [UIColor colorWithRed:70.0/255 green:193.0/255 blue:158.0/255 alpha:1]
#define LoginBgColor [UIColor colorWithRed:232.0/255 green:232.0/255 blue:232.0/255 alpha:1]
@interface LoginViewController ()<pioneer_navigationControllerDelegate,IChatManagerDelegate>
@property (strong, nonatomic) UILabel *usernameLB;     //

@property (strong, nonatomic) UIView *separateLine;     //分隔线
@property (strong, nonatomic) UIView *separateLineTwo;    //分隔线2
@property (strong, nonatomic) UILabel *pswLB;

@property (strong, nonatomic) UIButton *forgotBtn;     //忘记密码
@property (strong, nonatomic) UIButton *registeBtn;    //注册
@property (strong, nonatomic) UIButton *loginBtn;      //登录
@property (assign, nonatomic)  BOOL logYes;


@property (strong, nonatomic) UIImageView *settingImage;  //背景图
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;//键盘管理器
@end

@implementation LoginViewController
#pragma mark 自动布局
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    

    
    _settingImage.sd_layout.topSpaceToView(self.view,64).leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
    _usernameLB.sd_layout.topSpaceToView(self.settingImage,100).leftSpaceToView(self.settingImage,10).heightIs(40).widthIs(60);
    _usernameTF.sd_layout.topEqualToView(self.usernameLB).leftSpaceToView(self.usernameLB,10).widthRatioToView(self.settingImage, 0.7).heightIs(40);
    _separateLine.sd_layout.topSpaceToView(self.usernameLB,5).leftSpaceToView(self.settingImage, 5).rightSpaceToView(self.settingImage, 5).heightIs(1);
    
    _pswLB.sd_layout.topSpaceToView(self.separateLine, 20).leftEqualToView(self.usernameLB).widthIs(60).heightIs(40);
    _pswTF.sd_layout.topEqualToView(self.pswLB).leftSpaceToView(self.pswLB,10).widthRatioToView(self.settingImage,0.7).heightIs(40);
    _separateLineTwo.sd_layout.topSpaceToView(self.pswLB, 5).leftSpaceToView(self.settingImage, 5).rightSpaceToView(self.settingImage, 5).heightIs(1);
    
    _loginBtn.sd_layout.topSpaceToView(self.separateLineTwo,100).centerXEqualToView(self.settingImage).widthRatioToView(self.settingImage,0.8).heightRatioToView(self.settingImage, 0.07);
    _forgotBtn.sd_layout.topSpaceToView(self.loginBtn,3).rightEqualToView(self.loginBtn).widthIs(60).heightIs(20);
     _registeBtn.sd_layout.topSpaceToView(self.pioneer_navBar,12).rightSpaceToView(self.pioneer_navBar,5).widthIs(60).heightIs(20);
    
    
    
    
}
- (void)loadView
{
    self.view =  [[UIView alloc]initWithFrame:kContent_Frame];
    self.view.backgroundColor = LoginBgColor;
}
- (void)pioneer_signal
{
    RAC(self.loginBtn,enabled) = [RACSignal combineLatest:@[_usernameTF.rac_textSignal,_pswTF.rac_textSignal] reduce:^id(NSString *username, NSString *password){
        return @(YES);
        return @([username checkTelNumber] && [password checkPassword]);
    }];
    
    
    [self registeBtn];

    
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupForDismissKeyboard];
    self.barButtonType = PioneerBarButtonTypeBack;
    self.pioneerDelegate = self;
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    self.titleLB.text = @"登录";
    
//    [self.view addSubview:self.login_contentView];
    
    [self.view addSubview:self.settingImage];
    
    [self.settingImage addSubview:self.usernameLB];
    [self.settingImage addSubview:self.usernameTF];
//    [self.settingImage addSubview:self.userNameIcon];
    [self.settingImage addSubview:self.separateLine];
    
//    [self.settingImage addSubview:self.pswIcon];
    [self.settingImage addSubview:self.pswLB];
    [self.settingImage addSubview:self.pswTF];
    [self.settingImage addSubview:self.separateLineTwo];
    [self.view addSubview:self.forgotBtn];
    [self.pioneer_navBar addSubview:self.registeBtn];
    [self.view addSubview:self.loginBtn];
    [self pioneer_signal];
    [self registerEaseMobNotification];
    


}
#pragma mark 懒加载




//背景
- (UIImageView *)settingImage {
    if (!_settingImage) {
        self.settingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Azhucebeijing"]];
        _settingImage.userInteractionEnabled = YES;
    }
    return _settingImage;
}


- (UILabel *)usernameLB {
    
    if (!_usernameLB) {
        self.usernameLB = [UILabel new];
        _usernameLB.text = @"手机";
        _usernameLB.textAlignment = NSTextAlignmentCenter;
        _usernameLB.font = [UIFont systemFontOfSize:20];

    }
    return _usernameLB;
    }

-(UITextField *)usernameTF
{
    if(!_usernameTF){
        _usernameTF = [UITextField new];
        _usernameTF.placeholder = @"请输入手机号";
        _usernameTF.font = [UIFont systemFontOfSize:20];
//        _usernameTF.keyboardType = UIKeyboardTypeNumberPad;
        
    }
    return _usernameTF;
}

-(UIView *)separateLine
{
    if(!_separateLine){
        _separateLine = [UIView new];
        _separateLine.backgroundColor = [UIColor blackColor];
    }
    return _separateLine;
}

-(UIView *)separateLineTwo
{
    if(!_separateLineTwo){
        _separateLineTwo = [UIView new];
        _separateLineTwo.backgroundColor = [UIColor blackColor];
    }
    return _separateLineTwo;
}

- (UILabel *)pswLB {
    
    if (!_pswLB) {
        self.pswLB = [UILabel new];
        _pswLB.text = @"密码";
        _pswLB.textAlignment = NSTextAlignmentCenter;
         _pswLB.font = [UIFont systemFontOfSize:20];
        
    }
    return _pswLB;
}
-(UITextField *)pswTF
{
    if(!_pswTF){
        _pswTF = [UITextField new];
        _pswTF.placeholder = @"请输入密码";
        _pswTF.font = [UIFont systemFontOfSize:20];
        _pswTF.secureTextEntry = YES;
    }
    return _pswTF;
}

-(UIButton *)forgotBtn
{
    if(!_forgotBtn){
        _forgotBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_forgotBtn attributeStringWithString:@"找回密码"];
        _forgotBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [_forgotBtn addTarget:self action:@selector(forgotAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _forgotBtn;
}
- (void)forgotAction:(UIButton *)sender {
    MIssViewController *missVC = [MIssViewController new];
    
    [self.navigationController pushViewController:missVC animated:YES];
    
    
}

-(UIButton *)registeBtn
{
    if(!_registeBtn){
        _registeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registeBtn setTitle:@"注册" forState: UIControlStateNormal];
        
        [_registeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        @weakify(self);
        [[_registeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self.navigationController pushViewController:[RegisterViewController new] animated:YES];
        }];
    }
    return _registeBtn;
}
-(UIButton *)loginBtn
{
    if(!_loginBtn){
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIColorFromRGB(0x3ebed2) createImageWithColor]  forState:UIControlStateNormal];
        UIColor *disableColor = UIColorFromRGB(0x3ebed2);
        
        
        [_loginBtn setBackgroundImage:[disableColor createImageWithColor]  forState:UIControlStateDisabled];
        //
        //        [_loginBtn addTarget:self action:@selector(loginBth:) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.sd_cornerRadius = @5;
        
        @weakify(self);
        [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            [self.view endEditing:YES];
            
            //            登录流程
            BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
            
            if (!isAutoLogin) {
                
                
                
                //URL最好写入pch里面
                NSString *urlString = @"http://121.42.165.80/a/login";
                //构建请求模型
                LoginModel *loginModel = [[LoginModel alloc]initWithUserName:_usernameTF.text andPassword:_pswTF.text];
                
                //构建请求参数
                NSDictionary *param = [loginModel constructParam];
                
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
                
                [[manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"XXX%@",responseObject);
                
                    
                    //获取sessionid写入plist
                    BOOL isLogin = false;
                    NSString *sessionid = responseObject[@"sessionid"];
                    
                    
                    
                      NSString *userid = responseObject[@"id"];
                    if (sessionid) {
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        [defaults setObject:sessionid forKey:@"jeesite.session.id"];
                        
        
                        [defaults setObject:userid forKey:@"jeesite.session.usserid"];

                        [defaults synchronize];
                        
                
                        isLogin = true;
                        
                    }
                    
                    
                    [self performSelectorOnMainThread:@selector(infoShow:) withObject:@(isLogin) waitUntilDone:YES];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    if (error) {
                    }
                    //错误处理
                }]
                 
                 resume];
                
            }
            
        }];
    }
    return _loginBtn;
}
- (void)infoShow:(NSNumber *)isLogin
{
    BOOL login = isLogin.boolValue;
//    NSString *info = login ? @"登录成功" : @"登录失败";
    _logYes = YES;
    
//    [self showHint:info];
               //登录成功
    if (login) {
        [PioneerHelper changLoginStatus:YES];
        
        
        NSDictionary *dic = [[EaseMob sharedInstance].chatManager loginWithUsername:_usernameTF.text password:_pswTF.text error:nil];
        NSLog(@"###############################%@",dic);
        //        //        进入个人中心
        UIViewController *bottomVC = self.navigationController.viewControllers[0];
        
        [self.navigationController  popToViewController:bottomVC animated:YES];
        UITabBarController *mainTab = (UITabBarController *)bottomVC;
        
        mainTab.selectedIndex = 3;
        
        

    } else {
        [PioneerHelper changLoginStatus:NO];
                //登录失败
                [self showHint:@"用户名或密码错误" yOffset:50];

    }
    

        return;


    
}



- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}
#pragma mark 协议
- (void)dealloc
{
    self.returnKeyHandler = nil;
    [self unRegisterEaseMobNotification];
    NSLog(@"%s",__func__);
}
- (void)pioneer_navigationController:(pioneer_navigationController *)navigationController withPioneerBarButtonType:(PioneerBarButtonType)barButtonType
{
    if (PioneerBarButtonTypeBack == barButtonType) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    if (error)
    {
        [PioneerHelper changLoginStatus:NO];
        //登录失败
        [self showHint:@"用户名或密码错误" yOffset:50];
    }
    else
    {
        [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
        //登录成功
        [PioneerHelper changLoginStatus:YES];
//        进入个人中心
        UIViewController *bottomVC = self.navigationController.viewControllers[0];
        
        [self.navigationController  popToViewController:bottomVC animated:YES];
        UITabBarController *mainTab = (UITabBarController *)bottomVC;
        
        mainTab.selectedIndex = 3;
        return;
        
        
    }
}

@end
@implementation UIButton (LoginVC)

- (void)attributeStringWithString:(NSString *)string
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
    [attributeString addAttribute:NSUnderlineStyleAttributeName value:@1 range:NSMakeRange(0, attributeString.length)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:LoginRegisterColor range:NSMakeRange(0, attributeString.length)];
    [self setAttributedTitle:attributeString forState:UIControlStateNormal];
}

@end
