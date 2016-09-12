//
//  HeadTableViewCell.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/5.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "HeadTableViewCell.h"

@implementation HeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImage.clipsToBounds = YES;
    
//    _headImage.layer.borderWidth = 1.f;//设置边框宽度

    
    _headImage.layer.cornerRadius = 30.f;//设置边角圆弧的半径，设置3.f表示每个角是一个半径为3.f的圆弧；当圆半径为正方形view的边长的一半时，view就显示为一个圆。

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
