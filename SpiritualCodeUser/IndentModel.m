//
//  IndentModel.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/18.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "IndentModel.h"

@implementation IndentModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([@"user" isEqualToString:key]) {
    
        _phoneName = value[@"name"];
    }
    

}


@end
