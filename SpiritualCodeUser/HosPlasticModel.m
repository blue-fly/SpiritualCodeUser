//
//  HosPlasticModel.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/9/13.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "HosPlasticModel.h"

@implementation HosPlasticModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"primaryPerson"]) {
        _primaryPersonID = value[@"loginName"];
    }else if ([@"id" isEqualToString:key]) {
        self.ID = value;
    }
}


@end
