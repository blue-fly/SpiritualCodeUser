//
//  NSString+Utils.m
//  PartTimeMusic
//
//  Created by mac on 16/4/24.
//  Copyright © 2016年 pioneer. All rights reserved.
//

#import "NSString+Utils.h"
#import <RegexKitLite.h>
@implementation NSString (Utils)
#pragma mark----------正则匹配手机号

- (BOOL)checkTelNumber

{   NSString*pattern = @"0?(13|14|15|18)[0-9]{9}";
    if (self.length == 0) {
        return NO;
    }
    BOOL isMatch = [self isMatchedByRegex:pattern];
    
    return isMatch;
    
}

#pragma mark-------正则匹配用户密码6-18位数字和字母组合

- (BOOL)checkPassword
{
    
    NSString*pattern =@"^[0-9_a-zA-Z]{6,18}$";
    if (self.length == 0) {
        return NO;
    }
    BOOL isMatch = [self isMatchedByRegex:pattern];
    
    return isMatch;
    
}
- (BOOL)checkCertifyCode
{
    NSString *pattern = @"^\\d{4}$"; //验证四位数字
    if (self.length == 0) {
        return NO;
    }
    BOOL isMatch = [self isMatchedByRegex:pattern];
    return isMatch;
}
@end
