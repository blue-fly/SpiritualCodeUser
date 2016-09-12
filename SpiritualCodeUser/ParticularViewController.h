//
//  ParticularViewController.h
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/23.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "pioneer_navigationController.h"



@interface ParticularViewController : pioneer_navigationController<UITableViewDelegate, UITableViewDataSource,pioneer_navigationControllerDelegate>

- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic;

@end
