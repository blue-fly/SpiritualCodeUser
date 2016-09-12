//
//  AppDelegate.h
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/8.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EaseMob.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,IChatManagerDelegate>
{
    EMConnectionState _connectionState;  //网络状态变化
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UITabBarController *tabBar;

@end

