//
//  HospitalCell.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/17.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "HospitalCell.h"

@interface HospitalCell ()

@end

@implementation HospitalCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self prepareApprence];
}
    return self;
}

- (void)setHosModel:(HosModel *)hosModel {
    _hosModel = hosModel;
    NSLog(@"%@",_hosModel.name);
    if (self) {
        _nameLB.text = _hosModel.name;
        _addLB.text = _hosModel.address;
        
    }
}
@end
