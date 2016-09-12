//
//  AppDelegate+EaseMob.h
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/9.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (EaseMob)
//启动环信
//application: 应用程序
//launchOpitons: 启动项
//appkey: 应用程序key
//apnsCertName: 推送证书名称
//otherConfig: 其他配置
- (void)easeMobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                    appkey:(NSString *)appkey
              apnsCertName:(NSString *)apnsCertName
               otherConfig:(NSDictionary *)otherConfig;
@end
