//
//  PlasticCell.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/21.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "PlasticCell.h"


@implementation PlasticCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setHos2Model:(Hos2Model *)hos2Model {
    _hos2Model = hos2Model;
    
    if (self) {
        _introductionLB.text = hos2Model.title;
        _addres.text = hos2Model.officeModel.name;
        
    }
    
}

- (void)setPlasticModel:(PlasticModel *)plasticModel {
    plasticModel = plasticModel;
    
    
    if (self) {
        _introductionLB.text = plasticModel.title;
        
        _addres.text = plasticModel.officeModel.name;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
