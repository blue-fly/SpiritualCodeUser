//
//  CollectModel.h
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/9/13.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ModelTool.h"
#import "Collect1Model.h"
@interface CollectModel : ModelTool
@property (copy, nonatomic) NSString *officeName;
@property (copy, nonatomic) NSString *patientName;
@property (strong, nonatomic) Collect1Model *officeModel;
@end
