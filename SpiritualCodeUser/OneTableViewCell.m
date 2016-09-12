//
//  OneTableViewCell.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/7/25.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "OneTableViewCell.h"



@implementation OneTableViewCell
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    
//    NSArray *imageArr = [NSArray arrayWithObjects:@"gouwuche",@"jifen",@"shouchang1",@"tiezi", nil];
//    NSArray *lableArr = [NSArray arrayWithObjects:@"购物车",@"我的积分:",@"我的收藏",@"我的帖子", nil];
//    
//    
//    
//    
//    if (self) {
//        self.image = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _image.image = [UIImage imageNamed:@"%@", imageArr[]];
//        
//        
//        
//        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _priceLabel.textAlignment = NSTextAlignmentLeft;
//        
//        [self.contentView addSubview:self.image];
//        [self.contentView addSubview:self.priceLabel];
//        
//    }
//
//    
//    
//    return self;
//}

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [self initWithFrame:frame];
//    _image.sd_layout.centerXEqualToView(self.contentView).leftSpaceToView(self.contentView,10).widthEqualToHeight(30);
//   
//    
//    return self;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
