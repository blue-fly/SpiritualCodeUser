//
//  MedicalClassifyCell.h
//  YinDaoYeDemo
//
//  Created by pioneer on 16/8/7.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicalClassifyCell : UITableViewCell
@property (strong, nonatomic) NSString *ID;
@property (weak, nonatomic) IBOutlet UIButton *discountBth;
@property (weak, nonatomic) IBOutlet UIButton *hanguoBth;

@end
