//
//  HospitalCell.h
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/17.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HosModel.h"
@interface HospitalCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *addLB;

@property (strong, nonatomic)   HosModel *hosModel;

@end
