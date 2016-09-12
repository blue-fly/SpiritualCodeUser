//
//  PlasticModel.h
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/6.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ModelTool.h"
#import "Plastic2Model.h"
#import "Plastic3Model.h"
#import "Plastic4Model.h"

@interface PlasticModel : ModelTool
//@property (nonatomic, copy) NSString *description;

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *imageSrc;
@property (nonatomic, copy) NSString *peoples;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSString *office;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *isNewRecord;
@property (nonatomic, copy) NSString *posid;
@property (nonatomic, copy) NSString *hits;
@property (nonatomic, copy) NSString *user;

@property (nonatomic, strong)Plastic2Model *officeModel;

@property (nonatomic, strong)Plastic3Model *categoryModel;

@property (nonatomic, strong)Plastic4Model *articleModel;

@end
