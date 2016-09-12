//
//  Hos2Model.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/15.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "Hos2Model.h"

@implementation Hos2Model
- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    if ([key isEqualToString:@"office"]) {
        self.officeModel = [Hos22Model initModelWithDictionary:value];
    }
    if ([key isEqualToString:@"category"]) {
        self.categoryModel = [Hos33Model initModelWithDictionary:value];
    }

}

@end
