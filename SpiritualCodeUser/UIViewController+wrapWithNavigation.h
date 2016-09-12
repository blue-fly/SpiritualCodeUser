//
//  UIViewController+wrapWithNavigation.h
//  SpiritualCode
//
//  Created by pioneer on 16/6/26.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (wrapWithNavigation)
- (UINavigationController *)pioneer_wrapViewController;
- (UINavigationController *)pioneer_wrapViewControllerWithTitle:(NSString *)title;
- (UINavigationController *)pioneer_wrapViewControllerWithTitle:(NSString *)title withItemImageName:(NSString *)imageName;
@end
