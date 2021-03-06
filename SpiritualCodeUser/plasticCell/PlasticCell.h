//
//  PlasticCell.h
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/21.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlasticModel.h"
#import "Hos2Model.h"
#import "HosPlasticModel.h"

@interface PlasticCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *introductionLB;
@property (weak, nonatomic) IBOutlet UILabel *addres;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (strong, nonatomic) PlasticModel *plasticModel;
@property (strong, nonatomic) Hos2Model *hos2Model;
@property (strong, nonatomic) HosPlasticModel *hosPlasticModel;


@end
