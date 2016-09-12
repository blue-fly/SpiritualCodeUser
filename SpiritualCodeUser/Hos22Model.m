//
//  Hos22Model.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/15.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "Hos22Model.h"

@implementation Hos22Model
- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
