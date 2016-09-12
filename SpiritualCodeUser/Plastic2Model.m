//
//  Plastic2Model.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/6.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "Plastic2Model.h"

@implementation Plastic2Model
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
