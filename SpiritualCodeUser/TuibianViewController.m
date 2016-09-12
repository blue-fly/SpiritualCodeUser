//
//  TuibianViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/19.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "TuibianViewController.h"

@interface TuibianViewController ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *blackBth;

@end

@implementation TuibianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.width)];
    //    设置图片
    
    _imageView.image = [UIImage imageNamed:@"tuibianB"];
    //    设置图片比例的问题
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _imageView.userInteractionEnabled = YES;
    
    
    [self.imageView addSubview:self.blackBth];
    [self.view addSubview:self.imageView];

}
-(UIButton *)blackBth {
    if (!_blackBth) {
        self.blackBth = [UIButton buttonWithType:UIButtonTypeCustom];
        _blackBth.frame =CGRectMake(20, 20, 40, 40);
        
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
