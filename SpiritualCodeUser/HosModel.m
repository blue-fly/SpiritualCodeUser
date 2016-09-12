//
//  HosModel.m
//  
//
//  Created by SunXZ on 16/8/6.
//
//

#import "HosModel.h"

@implementation HosModel
- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
