//
//  Collect1Model.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/9/13.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "Collect1Model.h"

@implementation Collect1Model

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([@"article" isEqualToString:key]) {
        _articleTitle = value[@"title"];
        _articleappointprice = value[@"appointprice"];
    }else if ([@"office" isEqualToString:key]) {
        _officeName = value[@"name"];
    }
}


@end
