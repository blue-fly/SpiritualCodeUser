//
//  AdTableViewCell.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/7.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "AdTableViewCell.h"
#import "TuibianViewController.h"
#import "ZhaomuViewController.h"

@implementation AdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpViews];
    }
    return self;
    
}

//布局
- (void)setUpViews {
    
//    [self.tuibianBth setFrame:CGRectMake(0, 0, CGRectGetMaxX(self.bounds)/2, CGRectGetMaxY(self.bounds) - 30)];
    
}


- (IBAction)tuibianBth:(id)sender {
    self.tuibianBth.tag = 001;
    
}
- (IBAction)recruitBth:(id)sender {
    self.recruitBth.tag == 002;
}
- (IBAction)changeBth:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
