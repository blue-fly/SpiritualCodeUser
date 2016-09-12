//
//  SexTableViewCell.h
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/5.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SexTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *nvBth;
@property (weak, nonatomic) IBOutlet UIButton *nanBth;
@property (nonatomic, assign) BOOL isHave;

@end
