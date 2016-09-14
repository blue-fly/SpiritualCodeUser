//
//  CollectModel.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/9/13.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "CollectModel.h"

@implementation CollectModel
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([@"office" isEqualToString:key]) {
        _officeName = value[@"name"];
        
    }else if ([@"patient" isEqualToString:key]) {
        _patientName = value[@"name"];
    };
}
@end
