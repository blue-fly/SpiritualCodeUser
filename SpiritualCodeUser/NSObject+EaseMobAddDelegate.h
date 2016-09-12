//
//  NSObject+EaseMobAddDelegate.h
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/9.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EaseMob.h>
@interface NSObject (EaseMobAddDelegate)<IChatManagerDelegate>
- (void)registerEaseMobNotification;
- (void)unRegisterEaseMobNotification;
@end
