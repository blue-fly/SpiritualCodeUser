//
//  LoginViewController.h
//  SpiritualCode
//
//  Created by pioneer on 16/6/26.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pioneer_navigationController.h"


@interface LoginViewController : pioneer_navigationController
@property (strong, nonatomic) UITextField *pswTF;      //密码
@property (strong, nonatomic) UITextField *usernameTF; //用户名
@end
@interface UIButton (LoginVC)
- (void)attributeStringWithString:(NSString *)string;
@end