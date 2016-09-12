//
//  ADView.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/8.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ADView.h"

@interface ADView ()
@property (strong, nonatomic) UICollectionView *adColl; //滚动广告条
@end

@implementation ADView

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

-(UICollectionView *)adColl
{
    if(!_adColl){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _adColl = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _adColl;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
