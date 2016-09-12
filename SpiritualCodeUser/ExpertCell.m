//
//  ExpertCell.m
//  SpiritualCode
//
//  Created by pioneer on 16/6/27.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ExpertCell.h"
#import <UIImageView+WebCache.h>
#define ExpertContentColor [UIColor colorWithRed:70.0/255 green:193.0/255 blue:158.0/255 alpha:1]
#define BGColor [UIColor colorWithRed:225/255.0 green:237/255.0 blue:232/255.0 alpha:1]
@interface ExpertCell ()
@property (strong, nonatomic) UIView *expert_contentView;  //内容面板
@property (strong, nonatomic) UIImageView *headerImageV;   //头像
@property (strong, nonatomic) UILabel *nameLB;             //姓名
@property (strong, nonatomic) UILabel *telLB;              //电话
@property (strong, nonatomic) UILabel *articleLB;          //文章
@property (strong, nonatomic) UILabel *skillLB;            //技能
@end

@implementation ExpertCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = BGColor;
        [self.contentView addSubview:self.expert_contentView];
        [self.expert_contentView addSubview:self.headerImageV];
        [self.expert_contentView addSubview:self.nameLB];
        [self.expert_contentView addSubview:self.telLB];
        [self.expert_contentView addSubview:self.skillLB];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.tag != 0) {
        _expert_contentView.sd_resetLayout.topSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,5).leftSpaceToView(self.contentView,5).bottomSpaceToView(self.contentView,6);
    }
    else
    {
     _expert_contentView.sd_resetLayout.topSpaceToView(self.contentView,6).rightSpaceToView(self.contentView,5).leftSpaceToView(self.contentView,5).bottomSpaceToView(self.contentView,6);
    }
    _expert_contentView.sd_cornerRadius = @5;
    _headerImageV.sd_layout.topSpaceToView(_expert_contentView,10).leftSpaceToView(_expert_contentView,10).heightIs(75).widthEqualToHeight();
    _headerImageV.sd_cornerRadiusFromHeightRatio = @0.5;
    
    _nameLB.sd_layout.topEqualToView(_headerImageV).leftSpaceToView(_headerImageV,10).heightIs(35).widthRatioToView(_expert_contentView,0.5);
    
    _telLB.sd_layout.topSpaceToView(_nameLB,10).leftSpaceToView(_headerImageV,10).heightIs(35).widthRatioToView(_expert_contentView,0.5);
    
    _skillLB.sd_layout.topSpaceToView(_telLB,10).leftSpaceToView(_headerImageV,10).heightIs(35).rightSpaceToView(_expert_contentView,10);
}

-(UIView *)expert_contentView
{
    if(!_expert_contentView){
        _expert_contentView = [UIView new];
        _expert_contentView.backgroundColor = [UIColor whiteColor];
        
    }
    return _expert_contentView;
}
-(UIImageView *)headerImageV
{
    if(!_headerImageV){
        
        
        _headerImageV = [UIImageView new];
        _headerImageV.backgroundColor = ExpertContentColor;
        
    }
    return _headerImageV;
}
-(UILabel *)nameLB
{
    if(!_nameLB){
        _nameLB = [UILabel new];
     
    }
    return _nameLB;
}
-(UILabel *)telLB
{
    if(!_telLB){
        _telLB = [UILabel new];
     
    }
    return _telLB;
}
-(UILabel *)skillLB
{
    if(!_skillLB){
        _skillLB = [UILabel new];
    }
    return _skillLB;
}
- (void)setDataWithModel:(ExpertModel *)model
{
    self.nameLB.text = [NSString stringWithFormat:@"姓名：%@",model.specialistName];
    self.telLB.text =  model.displayName;
    self.skillLB.text = model.specialty;
    [self.headerImageV sd_setImageWithURL:[NSURL URLWithString:model.listProfilePicture]];
}
@end
