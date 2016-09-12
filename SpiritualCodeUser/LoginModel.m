//
//  LoginModel.m
//  ParamDemo
//
//  Created by pioneer on 16/8/10.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
- (instancetype)initWithUserName:(NSString *)userName andPassword:(NSString *)password
{
    if (self = [super init]) {
        _username = userName;
        _password = password;
        _mobileLogin = true;
        _isValidateCodeLogin = false;
    }
    return self;
}
//必须要实现的
- (NSDictionary *)constructParam
{
    if (_username != nil && _password != nil) {
        return @{@"username":_username,@"password":_password,@"mobileLogin":@(_mobileLogin),@"isValidateCodeLogin":@(_isValidateCodeLogin)};;
    }
    return nil;
}
@end
