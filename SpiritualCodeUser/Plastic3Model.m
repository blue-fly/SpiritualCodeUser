//
//  Plastic3Model.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/16.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "Plastic3Model.h"

@implementation Plastic3Model
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
