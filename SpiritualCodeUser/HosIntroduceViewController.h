//
//  HosIntroduceViewController.h
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/7/22.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "pioneer_navigationController.h"

@interface HosIntroduceViewController : pioneer_navigationController
@property (assign, nonatomic) NSString *ID;
@property (assign, nonatomic) NSString *introduceLB;
@property (assign, nonatomic) NSString * nameLB;
@property (assign, nonatomic) NSString *addLB;
- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic;
@end
