//
//  WelcomeViewController.m
//  YinDaoYeDemo
//
//  Created by pioneer on 16/8/6.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "WelcomeViewController.h"
#import "UIView+SDAutoLayout.h"
#import "ViewController.h"
@interface WelcomeViewController ()
@property(strong, nonatomic) UIScrollView *myScroll;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.myScroll];
}
- (void)viewWillLayoutSubviews
{
    _myScroll.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}
-(UIScrollView *)myScroll
{
    
    if(!_myScroll){
        _myScroll = [UIScrollView new];
        _myScroll.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) * 3, CGRectGetHeight([UIScreen mainScreen].bounds));
        _myScroll.bounces = NO;
        _myScroll.pagingEnabled = YES;
        for (int i = 1; i <= 3; i++) {
            UIImageView *myImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]]];
            myImage.userInteractionEnabled = YES;
            myImage.frame = CGRectMake((i - 1) * CGRectGetWidth([UIScreen mainScreen].bounds), 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"wantToTry.png"] forState:UIControlStateNormal];
            [myImage addSubview:btn];
            [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
            btn.sd_layout.bottomSpaceToView(myImage,10).centerXEqualToView(myImage).widthIs(200).heightIs(55);
            [_myScroll addSubview:myImage];
        }
    }
    return _myScroll;
}
- (void)btnClick
{
    //移除
    [UIApplication sharedApplication].keyWindow.rootViewController = [ViewController new];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
