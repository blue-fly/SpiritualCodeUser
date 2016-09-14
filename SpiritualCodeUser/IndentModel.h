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
#import "Indent4Model.h"

@interface IndentModel : ModelTool

@property (strong, nonatomic) Indent1Model *categoryModel;
@property (strong, nonatomic) Indent2Model *officeModel;
@property (strong, nonatomic) Indent3Model *articleModel;
@property (strong, nonatomic) Indent4Model *userModel;
@property (copy, nonatomic) NSString *orderNo;//订单号
@property (copy, nonatomic) NSString *unitprice;//预约金
@property (copy, nonatomic) NSString *orderStatus;//订单状态
@property (copy, nonatomic) NSString *totalprice;//总价
@property (copy, nonatomic) NSString *procount;//数量
@property (copy, nonatomic) NSString *phoneName;//手机号
@property (copy, nonatomic) NSString *orderFlag;//支付途径


@end
