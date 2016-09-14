//
//  Hos2Model.h
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/15.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ModelTool.h"
#import "Hos22Model.h"
#import "Hos33Model.h"

@interface Hos2Model : ModelTool

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *imageSrc;
@property (nonatomic, copy) NSString *peoples;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *isNewRecord;
@property (nonatomic, copy) NSString *posid;
@property (nonatomic, copy) NSString *hits;
@property (nonatomic, copy) NSString *user;
@property (nonatomic, copy) NSString *appointprice;
@property (nonatomic, copy) NSString *busprice;
@property (nonatomic, strong) Hos22Model *officeModel;
@property (nonatomic, strong) Hos33Model *categoryModel;
@property (nonatomic, copy) NSString *userPhone;
@end
