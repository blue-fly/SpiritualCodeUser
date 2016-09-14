//
//  singleModel.h
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/9/14.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ModelTool.h"
#import "Singleton.h"
#import "Hos2Model.h"
@interface singleModel : ModelTool
singleton_h(SingleModels);
@property (strong, nonatomic) Hos2Model *single_hos2Model;

@end
