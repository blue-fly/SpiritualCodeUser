//
//  AppDelegate.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/8.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+EaseMob.h"
#import <SDWebImage/SDWebImageManager.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <IQKeyboardManager.h>
#import "ViewController.h"
#import "LXAlertView.h"
#import "LoginViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "HTTPManager.h"
#import "ExpertModel.h"
#import <EaseBaseMessageCell.h>
#import "MyViewController.h"
#import <UMSocial.h>
#import <UMSocialQQHandler.h>
#import <UMSocialWechatHandler.h>
#import "LoginViewController.h"
#import <AlipaySDK/AlipaySDK.h>

#import "WXApi.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
@interface AppDelegate ()<WXApiDelegate>
@property (strong, nonatomic) LoginViewController *logVC;
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    NSLog(@"path   %@",NSHomeDirectory());
//微信支付
    [WXApi registerApp:@"wx012054e78d1925ad"];

    
    
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"57a8891b67e58ee737000c76"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx012054e78d1925ad" appSecret:@"7b3fa15eaa8b0921200ea8fb34f7e36c" url:@"http://www.umeng.com/social"];

    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self textData];
#ifdef __IPHONE_8_0
    [[UIApplication  sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
#endif
    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[UIImage imageNamed:@"chat_sender_bg"]];
    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[UIImage imageNamed:@"chat_receiver_bg"]];
    //注册SharedSDK短信App
    [SMSSDK registerApp:@"103959bca5137" withSecret:@"9f0b2b8aa54c74a10d45993ef0d22865"];
    //启动环信SDK
    [self easeMobApplication:application didFinishLaunchingWithOptions:launchOptions appkey:@"91370211ma3ccbm25n#xlmm" apnsCertName:nil otherConfig:nil];
    
    NSDictionary *dic = [[EaseMob sharedInstance].chatManager loginWithUsername:@"15541855117" password:@"qwer" error:nil];
    NSLog(@"%@",dic);
    self.window.rootViewController = [ViewController new];
    
    return YES;
}
- (void)textData
{
    NSArray *arrayOne = @[@"北京朝阳医院",@"胡永东",@"诊治各种情绪、压力问题，失眠，心理障碍、抑郁症等。尤其是在失眠的药物与非药物治疗的结合、抑郁症的筛查、早期识别、早期规范治疗有较丰富经验。在心理治疗上，强调以精神分析、导引催眠为主的整合性心理治疗。\\r\\n",@"胡永东，北京大学医学部精神卫生研究所精神卫生专业硕士，现为首都医科大学附属北京朝阳医院心理科主任医师。\\r\\n具备丰富的科研、教学、科普宣传经验，目前参与国家科技支撑计划课题、国家自然科学基金、国家中医药管理局国际合作司等课题。发表国际SCI论文2篇，在国内专业期刊杂志发表论文20余篇。现在5个学术组织任委员或常务理事：北京医师协会精神科医师专家委员会委员、朝阳区预防医学会精神卫生分会委员、世界中医药学会联合会中医心理学专业委员会第二届理事会常务理事、中国性学会第四届性医学专业委员会委员、中华医学会行为医学分会第四届委员会青年委员会委员) 。 曾获中国中医科学院科学技术奖三等奖，曾获中国医师协会精神科分会第四届年会优秀论文奖、中国中医科学院广安门医院2010年度SCI论文发表奖。 \\r\\n积极参与报纸、网站、电视台的科普宣传，曾参加中央电视台《健康之路》栏目；曾在《健康报》等多家报纸杂志发表科普文章若干。\\r\\n",@"http://wx.15120.cn/AppApi2/Files/Media/Uploads/2016/04/06/4a385106-1a04-4cd8-b3b8-d5f078816cfd.png",@"11111"];
    NSArray *arrayTwo = @[@"北京大学第六医院",@"孙伟",@"睡眠障碍；抑郁症；酒精和药物依赖；心理治疗。",@"孙伟，男，2009年7月毕业于北京大学，获临床医学博士学位。2009年8月起就职于北京大学第六医院，现为副主任医师。专业方向：睡眠障碍、抑郁症、酒精和药物依赖、心理治疗。 ",@"http://wx.15120.cn/AppApi2/Files/Media/Uploads/2016/04/14/6f44af46-ad77-4563-b2f3-eb02ec81743d.png",@"22222"];
    ExpertModel *modelOne = [[ExpertModel alloc]initWIthArray:arrayOne];
    ExpertModel *modelTwo = [[ExpertModel alloc]initWIthArray:arrayTwo];
    //写入本地
    NSArray *modelArray = @[modelOne,modelTwo];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:modelArray];
    NSString *destination = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *file = [destination stringByAppendingPathComponent:@"expert"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:file]) {
        [data writeToFile:file atomically:YES];
    }
    NSLog(@"destination %@",destination);
}
//添加主题框架

- (void)setUpKeyManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = NO;
    manager.keyboardDistanceFromTextField = 0;   //设置焦点距键盘的距离
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
        //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
        if ([url.host isEqualToString:@"safepay"]) {
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
                NSLog(@"result = %@",resultDic);
            }];
        }
        if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
            
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
                //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
                NSLog(@"result = %@",resultDic);
            }];
        }
    }
    
    
    return [WXApi handleOpenURL:url delegate:self];

    return result;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//tabBar 切换协议事件
//判断用户是否登录
//登录：展示我的界面
//未登录：去登录界面
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UINavigationController *navc = (UINavigationController *)viewController;
    UIViewController *selectedVC = navc.viewControllers[0];
    if (isLogins || ![selectedVC isKindOfClass:[MyViewController class]] || [[EaseMob sharedInstance].chatManager isAutoLoginEnabled]) {
        return YES;
    }
    LXAlertView *alertView = [[LXAlertView alloc]initWithTitle:@"温馨提示" message:@"你还未登录" cancelBtnTitle:@"取消" otherBtnTitle:@"去登陆" clickIndexBlock:^(NSInteger clickIndex) {
        if (clickIndex == 1) {
            [tabBarController.navigationController pushViewController:[LoginViewController new] animated:YES];
        }
        
    }];
    [alertView showLXAlertView];
    return NO;
}
//清缓存
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDWebImageManager sharedManager] cancelAll];
    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
    
}
@end
