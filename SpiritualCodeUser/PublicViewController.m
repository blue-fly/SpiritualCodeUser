//
//  PublicViewController.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/12.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "PublicViewController.h"
#import "TLCityPickerController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface PublicViewController ()<pioneer_navigationControllerDelegate,TLCityPickerDelegate,CLLocationManagerDelegate>

@end

@implementation PublicViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLB.text = @"地图";
    self.barButtonType = PioneerBarButtonTypeBack;
    self.pioneerDelegate = self;
}
#pragma mark 懒加载
#pragma mark 自动布局
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}











#pragma mark 协议
- (void)pioneer_navigationController:(pioneer_navigationController *)navigationController withPioneerBarButtonType:(PioneerBarButtonType)barButtonType
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
