//
//  OrderListCell.m
//  XibDemo
//
//  Created by pioneer on 16/8/13.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "OrderListCell.h"


@implementation OrderListCell

- (void)awakeFromNib {
    // Initialization code
   
   

}

- (void)setIndentModel:(IndentModel *)indentModel {
    _indentModel = indentModel;
    if (self) {
        
        _indentLB.text = _indentModel.orderNo;
        
        _nameLB.text = _indentModel.articleModel.title;
        _priceLB.text =    [NSString stringWithFormat:@"%@", _indentModel.unitprice];
        _payLB.text =  [NSString stringWithFormat:@"%@", _indentModel.unitprice];
        _numberLB.text = [NSString stringWithFormat:@"%@", _indentModel.procount];



           }
    
    
    }




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
