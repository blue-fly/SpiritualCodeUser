//
//  LoginModel.h
//  ParamDemo
//
//  Created by pioneer on 16/8/10.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IModelTool.h"
//登录数据模型
@interface LoginModel : NSObject<IModelTool>
@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *password;
@property (nonatomic, assign) BOOL mobileLogin;
@property (nonatomic, assign) BOOL isValidateCodeLogin;
- (instancetype)initWithUserName:(NSString *)userName andPassword:(NSString *)password;
- (NSDictionary *)constructParam;//请求参数构建
@end
