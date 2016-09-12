//
//  IndentModel.h
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/18.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ModelTool.h"
#import "Indent1Model.h"
#import "Indent2Model.h"
#import "Indent3Model.h"

@interface IndentModel : ModelTool

@property (strong, nonatomic) Indent1Model *categoryModel;
@property (strong, nonatomic) Indent2Model *officeModel;
@property (strong, nonatomic) Indent3Model *articleModel;
@property (copy, nonatomic) NSString *orderNo;//订单号
@property (copy, nonatomic) NSString *unitprice;//预约金
@property (copy, nonatomic) NSString *orderStatus;//订单状态


@end
