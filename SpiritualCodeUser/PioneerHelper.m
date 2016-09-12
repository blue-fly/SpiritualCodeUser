//
//  PioneerHelper.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/10.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "PioneerHelper.h"


@implementation PioneerHelper
+ (void)changLoginStatus:(BOOL)status
{
    [[NSUserDefaults standardUserDefaults] setObject:@(status) forKey:@"pioneer_isLogin"];
}

@end
