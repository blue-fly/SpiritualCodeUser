//
//  PlasticViewController.h
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/7/21.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "pioneer_navigationController.h"

@interface PlasticViewController : pioneer_navigationController
@property (strong, nonatomic) NSString *IDs;
- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic;

@end
