//
//  ConditionView.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/17.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ConditionView.h"
#import "ExpertViewController.h"

@interface ConditionView ()
@property (strong, nonatomic) UIButton *tuiJianBtn;
@property (strong, nonatomic) UIButton *hotBtn;
@property (strong, nonatomic) UIButton *guiMoBtn;
@property (strong, nonatomic) UIButton *shaiXuanBtn;
@property (strong, nonatomic) UIView *bottomLineView;
@property (weak, nonatomic) UIButton *currentSelect;
@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) ExpertViewController *expertViewController;
@end

@implementation ConditionView
- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.tuiJianBtn];
        [self addSubview:self.hotBtn];
//        [self addSubview:self.guiMoBtn];
//        [self addSubview:self.shaiXuanBtn];
//        [self addSubview:self.image];
        [self addSubview:self.bottomLineView];
        self.tag = 1002;
        self.currentSelect = self.tuiJianBtn;
        _tuiJianBtn.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,0).bottomSpaceToView(self,0).widthRatioToView(self,0.5);
        _hotBtn.sd_layout.topSpaceToView(self,0).leftSpaceToView(_tuiJianBtn,0).bottomSpaceToView(self,0).widthRatioToView(self,0.5);
//        _guiMoBtn.sd_layout.topSpaceToView(self,0).leftSpaceToView(_hotBtn,0).bottomSpaceToView(self,0).widthRatioToView(self,0.27);
//        _shaiXuanBtn.sd_layout.topSpaceToView(self,0).leftSpaceToView(_guiMoBtn,0).bottomSpaceToView(self,0).rightSpaceToView(self,0);
//        _image.sd_layout.topSpaceToView(self,0).leftSpaceToView(_shaiXuanBtn,0).bottomSpaceToView(self,0).rightSpaceToView(self,0);

        
        UIView *lineView = [UIView new];
        lineView.tag = 1001;
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        lineView.sd_layout.topSpaceToView(self,0).rightSpaceToView(_shaiXuanBtn,0).bottomSpaceToView(self,0).widthIs(1);
    }
    return self;
}
-(UIButton *)tuiJianBtn
{
    if(!_tuiJianBtn){
        _tuiJianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tuiJianBtn setTitle:@"推荐" forState:UIControlStateNormal];
        [_tuiJianBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_tuiJianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        _tuiJianBtn.selected = YES;
        _tuiJianBtn.tag = 0;
        [_tuiJianBtn addTarget:self action:@selector(moveConditionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tuiJianBtn;
}
-(UIButton *)hotBtn
{
    if(!_hotBtn){
        _hotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hotBtn setTitle:@"最热" forState:UIControlStateNormal];
        [_hotBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_hotBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        _hotBtn.selected = NO;
        _hotBtn.tag = 1;
        [_hotBtn addTarget:self action:@selector(moveConditionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _hotBtn;
}
//-(UIButton *)guiMoBtn
//{
//    if(!_guiMoBtn){
//        _guiMoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_guiMoBtn setTitle:@"规模" forState:UIControlStateNormal];
//        [_guiMoBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [_guiMoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//        _guiMoBtn.selected = NO;
//        _guiMoBtn.tag = 2;
//        [_guiMoBtn addTarget:self action:@selector(moveConditionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _guiMoBtn
//    ;
//}
//-(UIButton *)shaiXuanBtn
//{
//    if(!_shaiXuanBtn){
//        _shaiXuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_shaiXuanBtn setTitle:@"筛选" forState:UIControlStateNormal];
//        [_shaiXuanBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [_shaiXuanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//        
//        _shaiXuanBtn.selected = NO;
//        _shaiXuanBtn.tag = 3;
//        [_shaiXuanBtn addTarget:self action:@selector(moveConditionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _shaiXuanBtn;
//}
//
//- (UIImageView *)image {
//    if (_image) {
//        self.image = [UIImageView new];
//        _image.image = [UIImage imageNamed:@"shaixuan"];
//        _image.contentMode = UIViewContentModeScaleAspectFill;
//    }
//    return _image;
//}


-(UIView *)bottomLineView
{
    if(!_bottomLineView){
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = [UIColor redColor];
        _bottomLineView.tag = 1002;
        _bottomLineView.frame = CGRectMake(0 , 39, 0.5 * kContent_Width, 3);
    }
    return _bottomLineView;
}
- (void)moveConditionBtnClick:(UIButton *)sender
{
    self.currentSelect.selected = NO;
    self.currentSelect = sender;
    sender.selected = YES;
    [self moveBottonLine];
    if ([_delegate respondsToSelector:@selector(conditionView:withSelectIndex:)]) {
        [_delegate conditionView:self withSelectIndex:(int)sender.tag];
    }
}
- (void)moveBottonLine
{
    static float mutiple = 0.5;
    [UIView animateWithDuration:0.5 animations:^{
    
        if (self.currentSelect == self.shaiXuanBtn) {
            _bottomLineView.frame = CGRectMake(0, 39, 0.5 * kContent_Width, 3);
        }
        else
        {
            _bottomLineView.frame = CGRectMake(self.currentSelect.tag * 0.5 * kContent_Width, 39, mutiple * kContent_Width, 3);
        }
    }];
}
- (void)outerControlWithIndex:(int)index
{
    UIView *view = [self viewWithTag:index];
    self.currentSelect = (UIButton*)view;
    [self moveBottonLine];
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
