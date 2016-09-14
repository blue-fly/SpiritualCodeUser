//
//  HosPlasticTableViewCell.h
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/9/13.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HosPlasticModel.h"
@interface HosPlasticTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *addressLB;
@property (nonatomic, strong) HosPlasticModel *hosPlasticModel;
@end
