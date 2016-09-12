//
//  UIViewController+wrapWithNavigation.m
//  SpiritualCode
//
//  Created by pioneer on 16/6/26.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "UIViewController+wrapWithNavigation.h"
//为视图控制器添加导航封装(类别)
@implementation UIViewController (wrapWithNavigation)
- (UINavigationController *)pioneer_wrapViewController
{
    return [[UINavigationController alloc]initWithRootViewController:self];
}
- (UINavigationController *)pioneer_wrapViewControllerWithTitle:(NSString *)title
{
    UINavigationController *nav = [self pioneer_wrapViewController];
    nav.tabBarItem.title = title;
    
    return nav;
}
- (UINavigationController *)pioneer_wrapViewControllerWithTitle:(NSString *)title withItemImageName:(NSString *)imageName
{
    UINavigationController *nav = [self pioneer_wrapViewController];
    nav.navigationBarHidden = YES;
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:imageName] tag:0];
    return nav;
}
@end
