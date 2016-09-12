//
//  ZhaomuViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/19.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ZhaomuViewController.h"

@interface ZhaomuViewController ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *blackBth;

@end

@implementation ZhaomuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self.imageView addSubview:self.blackBth];
    [self.view addSubview:self.imageView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _blackBth.sd_layout.topSpaceToView(self.imageView,20).leftSpaceToView(self.imageView, 20).widthIs(40).heightIs(40);
    
}

- (UIImageView *)imageView {
    if (!_imageView) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
        
        //    设置图片
        
        _imageView.image = [UIImage imageNamed:@"zhaomuB"];
        //    设置图片比例的问题
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.userInteractionEnabled = YES;

    }
    
    return _imageView;
   

}

- (UIButton *)blackBth {
    if (!_blackBth) {
        
        self.blackBth = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_blackBth setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
        
        
        [_blackBth addTarget:self action:@selector(LogButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _blackBth;
}

- (void)LogButton:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
