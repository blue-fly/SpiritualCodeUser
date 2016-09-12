//
//  Hos33Model.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/17.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "Hos33Model.h"

@implementation Hos33Model
- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
