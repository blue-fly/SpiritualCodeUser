//
//  ComfirmModel.h
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/17.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ModelTool.h"



@interface ComfirmModel : ModelTool
@property (copy, nonatomic)NSString *userID;
@property (copy, nonatomic)NSString *officeID;
@property (copy, nonatomic)NSString *articleID;
@property (copy, nonatomic)NSString *categoryID;
@property (copy, nonatomic)NSString *unitprice;
@property (copy, nonatomic)NSString *totalprice;
@property (copy, nonatomic)NSString *orderNO;
@property (copy, nonatomic)NSString *procount;
@property (copy, nonatomic)NSString *orderStatus;
@property (copy, nonatomic)NSString *orderFlag;
@property (copy, nonatomic)NSString *proDesc;



- (instancetype)initWithUserID:(NSString *)userID andofficeID:(NSString *)officeID andarticleID:(NSString *)articleID andcategoryID:(NSString *)categoryID andunitprice:(NSString *)unitprice andtotalprice:(NSString *)totalprice andorderNO:(NSString *)orderNO andprocount:(NSString *)procount andorderStatus:(NSString *)orderStatus andorderFlag:(NSString *)orderFlag andproDesc:(NSString *)proDesc;
- (NSDictionary *)confirmParam;//请求参数构建
@end

