//
//  OrderListCell.h
//  XibDemo
//
//  Created by pioneer on 16/8/13.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndentModel.h"
@interface OrderListCell : UITableViewCell
@property (strong, nonatomic) IndentModel *indentModel;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *addresLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UILabel *indentLB;

@end
