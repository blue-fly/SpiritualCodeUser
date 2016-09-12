//
//  PhotoCollectionViewCell.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/24.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "PhotoTableViewCell.h"


@implementation PhotoCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
      
        [self imageView];
        

        
        
    }
    return self;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
        
        _imageView.frame = self.contentView.bounds;
        
        _imageView.userInteractionEnabled = YES;
        
        
        //添加点击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [_imageView addGestureRecognizer:tapGesture];
        [self.contentView addSubview:self.imageView];
    }
    return _imageView;
}

- (void) tapAction{
    
    
//    NSArray *imagearr = @[@"sun", @"1",@"2",@"sun",@"sun",@"sun"];
    self.photoDisplayHelper = [[PhotoDisplayHelper alloc] initWithImages:_imagearr withIndex:self.tag];
    id temp = nil;
    temp = self.nextResponder;
    while (temp) {
      NSString *className = NSStringFromClass([temp class]);
        if ([@"ParticularViewController" isEqualToString:className]) {
            break;
        }
      temp = [temp nextResponder];
    }
    UIViewController *tempVC = (UIViewController *)temp;
    [tempVC.navigationController pushViewController:(UIViewController *)(self.photoDisplayHelper.pioneer_browserVC) animated:NO];
    
    
    return;
    
    
//    //创建一个黑色背景
//    //初始化一个用来当做背景的View。
//    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
//    _background = bgView;
//    [bgView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.22]];
//    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
//    
//    //创建显示图像的视图
//    //初始化要显示的图片内容的imageView（这里位置继续偷懒...没有计算）
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.window.frame.size.width, 300)];
//    //要显示的图片，即要放大的图片
//    [imgView setImage:[UIImage imageNamed:@"sun"]];
//    [bgView addSubview:imgView];
//    imgView.userInteractionEnabled = YES;
//    //添加点击手势（即点击图片后退出全屏）
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
//    [bgView addGestureRecognizer:tapGesture];
//    
//    [self shakeToShow:bgView];//放大过程中的动画
}
//-(void)closeView{
//    [_background removeFromSuperview];
//}
////放大过程中出现的缓慢动画
//- (void) shakeToShow:(UIView*)aView{
//    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    animation.duration = 0.5;
//    NSMutableArray *values = [NSMutableArray array];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//    animation.values = values;
//    [aView.layer addAnimation:animation forKey:nil];
//}
@end
