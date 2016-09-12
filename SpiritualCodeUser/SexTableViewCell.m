//
//  SexTableViewCell.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/5.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "SexTableViewCell.h"

@implementation SexTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    [_nvBth setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
    [_nanBth setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];

    self.isHave = YES;
    
    
}



- (IBAction)nvBth:(id)sender {
    _isHave = YES;
    [self freshBtuColor];
          
}
- (IBAction)nanBth:(id)sender {


    _isHave = NO;
    [self freshBtuColor];
}


- (void)freshBtuColor {
    if (_isHave) {
        [_nvBth setImage:[UIImage imageNamed:@"yuan1"] forState:UIControlStateNormal];
        [_nanBth setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
       
        _isHave = NO;
    } else {
        [_nvBth setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
        [_nanBth setImage:[UIImage imageNamed:@"yuan1"] forState:UIControlStateNormal];
        _isHave = YES;
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
