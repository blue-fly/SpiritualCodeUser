//
//  AppDelegate+EaseMob.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/9.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "AppDelegate+EaseMob.h"
#import <EaseMobSDKFull/EaseMob.h>
#import "NSObject+EaseMobAddDelegate.h"
@implementation AppDelegate (EaseMob)
- (void)easeMobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                    appkey:(NSString *)appkey
              apnsCertName:(NSString *)apnsCertName
               otherConfig:(NSDictionary *)otherConfig
{
    [[EaseMob sharedInstance] registerSDKWithAppKey:appkey apnsCertName:nil otherConfig:nil];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [self registerEaseMobNotification];
    
}
// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

// 申请处理时间
- (void)applicationWillTerminate:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}
#pragma mark - EMChatManagerUtilDelegate

// 网络状态变化回调
- (void)didConnectionStateChanged:(EMConnectionState)connectionState
{
    _connectionState = connectionState;
    switch (connectionState) {
        case eEMConnectionConnected:
        {
            NSLog(@"成功");
        }
            break;
        case eEMConnectionDisconnected:
        {
            NSLog(@"失败");
        }
            break;
        default:
            break;
    }
}

@end
