//
//  ViewController.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/8.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ViewController.h"
#import "MainPageViewController.h"
#import "ExpertViewController.h"
#import "MessageViewController.h"
#import "UIViewController+wrapWithNavigation.h"
#import "AppDelegate.h"
#import "MyViewController.h"
#import "WelcomeViewController.h"
@interface ViewController ()
@property (strong, nonatomic) UIImageView *welcomeImage; //欢迎图片
@end

@implementation ViewController

- (void)loadView
{
    self.view =  [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.welcomeImage];
    [self performSelector:@selector(delayLanchImage) withObject:nil afterDelay:1.5];
}
- (void)viewWillLayoutSubviews
{
    _welcomeImage.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}
-(UIImageView *)welcomeImage
{
    if(!_welcomeImage){
        _welcomeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading"]];
    }
    return _welcomeImage;
}
//设定程序主界面层次结构
- (void)setUpMainFrame
{
    MainPageViewController *main = [[MainPageViewController alloc]init];
    
      UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:main];
    mainNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"shouye"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage:[[UIImage imageNamed:@"shouye1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    
                                       
//                                       pioneer_wrapViewControllerWithTitle:@"首页" withItemImageName:@"shouye"];
    
    ExpertViewController *expert = [ExpertViewController new];
//pioneer_wrapViewControllerWithTitle:@"医院" withItemImageName:@"zhuanjia"];
    UINavigationController *expertNav = [[UINavigationController alloc] initWithRootViewController:expert];
    expertNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"机构" image:[[UIImage imageNamed:@"yiyuan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage:[[UIImage imageNamed:@"yiyuan1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    expertNav.navigationBarHidden = YES;
    
    
    MessageViewController *message = [MessageViewController new];
    
    UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:message];
    messageNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[[UIImage imageNamed:@"xiaoxi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage:[[UIImage imageNamed:@"xiaoxi1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
       messageNav.navigationBarHidden = YES;

    
//    UINavigationController *messageNav = [messageVC pioneer_wrapViewControllerWithTitle:@"消息" withItemImageName:@"xiaoxi"];
    
    messageNav.topViewController.view.backgroundColor = [UIColor yellowColor];
    
    
     MyViewController *mine = [MyViewController new];
    
    
//pioneer_wrapViewControllerWithTitle:@"我的" withItemImageName:@"wode"];
    
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mine];
    mineNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"wode"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage:[[UIImage imageNamed:@"wode1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    


    
    NSArray *navs = @[mainNav,expertNav,messageNav,mineNav];
    
    
    [message setupUnreadMessageCount];
    UITabBarController *mainTab = [[UITabBarController alloc]init];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    mainTab.delegate = app;
    mainTab.tabBar.tintColor = UIColorFromRGB(0x3ebed2);
    
    UINavigationController *tabNav = [[UINavigationController alloc]initWithRootViewController:mainTab];
    
    WelcomeViewController *welVC = [[WelcomeViewController alloc] init];
    tabNav.navigationBarHidden = YES;
    mainTab.viewControllers = navs;
    mainTab.hidesBottomBarWhenPushed = YES;
    
    
    BOOL isFirst = [[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"];
    //    判断
    if (!isFirst) {
        //        ??
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [UIApplication sharedApplication].keyWindow.rootViewController = welVC;

        
    }else{
        
               [UIApplication sharedApplication].keyWindow.rootViewController = tabNav;


    }

    
}

- (void)delayLanchImage
{
    self.welcomeImage.image = [UIImage imageNamed:@"loading"];
    [self performSelector:@selector(setUpMainFrame) withObject:nil afterDelay:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
