//
//  NSObject+EaseMobAddDelegate.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/9.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "NSObject+EaseMobAddDelegate.h"
@implementation NSObject (EaseMobAddDelegate)
#pragma mark - registerEaseMobNotification

- (void)registerEaseMobNotification{
    [self unRegisterEaseMobNotification];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}
- (void)unRegisterEaseMobNotification{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}
@end
