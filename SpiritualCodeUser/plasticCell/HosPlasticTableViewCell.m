//
//  HosPlasticTableViewCell.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/9/13.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "HosPlasticTableViewCell.h"

@implementation HosPlasticTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setHosPlasticModel:(HosPlasticModel *)hosPlasticModel {
    _hosPlasticModel = hosPlasticModel;

        _nameLB.text = _hosPlasticModel.name;
        _addressLB.text = _hosPlasticModel.address;


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
