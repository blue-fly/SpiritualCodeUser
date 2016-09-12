//
//  ComfirmModel.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/17.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ComfirmModel.h"

@implementation ComfirmModel

- (instancetype)initWithUserID:(NSString *)userID andofficeID:(NSString *)officeID andarticleID:(NSString *)articleID andcategoryID:(NSString *)categoryID andunitprice:(NSString *)unitprice andtotalprice:(NSString *)totalprice andorderNO:(NSString *)orderNO andprocount:(NSString *)procount andorderStatus:(NSString *)orderStatus andorderFlag:(NSString *)orderFlag andproDesc:(NSString *)proDesc;{
    if (self = [super init]) {
        _userID = userID;
        _officeID = officeID;
        _categoryID = categoryID;
        _articleID = articleID;
        
        _unitprice = unitprice;
        _totalprice = totalprice;
        _orderNO = orderNO;
        _procount = procount;
        _orderStatus = orderStatus;
        _orderFlag = orderFlag;
        _proDesc = proDesc;
    }
    return self;
}

-(NSDictionary *)confirmParam {
    
    if (_userID !=nil && _officeID !=nil && _categoryID!= nil && _unitprice != nil && _totalprice != nil && _orderNO != nil && _procount != nil && _orderStatus != nil && _articleID != nil && _proDesc != nil && _orderFlag != nil) {
        
        
        return@{@"category.id":_categoryID,@"user.id":_userID,@"office.id":_officeID,@"article.id":_articleID,@"orderNo":_orderNO,@"orderStatus":_orderStatus,@"unitprice":_unitprice,@"procount":_procount,@"totalprice":_totalprice,@"orderFlag":_orderFlag,@"proDesc":_procount};
    }
    
    return nil;
}


@end
