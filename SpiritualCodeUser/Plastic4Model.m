//
//  Plastic4Model.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/30.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "Plastic4Model.h"

@implementation Plastic4Model


- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
