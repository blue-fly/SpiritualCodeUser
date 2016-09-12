//
//  PlasticModel.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/6.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "PlasticModel.h"

@implementation PlasticModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
