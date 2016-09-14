//
//  SetViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/7/25.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "SetViewController.h"
#import "OneTableViewCell.h"
#import "TwoTableViewCell.h"
#import <EaseMob.h>
#import "UIImageView+WebCache.h"
#import <MBProgressHUD.h>
#import "UIViewController+HUD.h"
#import "SendFeedbackViewController.h"
#import "ProtocolViewController.h"

@interface SetViewController ()<pioneer_navigationControllerDelegate,UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *bottomTB;
@property (strong, nonatomic) NSArray *imageArr; //图片数组
@property (strong, nonatomic) NSArray *lableArr; //文字数组
@property (strong, nonatomic) UIButton *exitBth;


@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xf2f7f5);
    self.titleLB.text = @"设置";
    self.barButtonType = PioneerBarButtonTypeBack;
    self.pioneerDelegate = self;
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.bottomTB];
    [self.view addSubview:self.exitBth];
    self.imageArr = [NSArray arrayWithObjects:@"lajitong",@"yijianfankui",@"xiangguanxieyi", nil];
    
    self.lableArr = [NSArray arrayWithObjects:@"清理缓存",@"意见反馈",@"相关协议", nil];
    
    self.bottomTB.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _bottomTB.sd_layout.topSpaceToView(self.view,64).self.leftEqualToView(self.view).rightEqualToView(self.view).heightRatioToView(self.view,0.5);
    _exitBth.sd_layout.topSpaceToView(_bottomTB,10).widthRatioToView(self.view,0.8).heightIs(40).centerXEqualToView(self.view);
    
    }

- (UIButton *)exitBth {
    if (!_exitBth) {
        _exitBth = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exitBth setTitle:@"退出登录" forState:UIControlStateNormal];
        [_exitBth addTarget:self action:@selector(exitAction:) forControlEvents:UIControlEventTouchUpInside];
        _exitBth.backgroundColor = UIColorFromRGB(0xfc1327);
        
          _exitBth.sd_cornerRadius = @5;
    }
    return _exitBth;
}

- (void)exitAction:(UIButton *)sender {
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (!error) {
//            [self showHint:@"退出登录" yOffset:50];
            [PioneerHelper changLoginStatus:NO];
            self.tabBarController.selectedIndex = 0;
            
//            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
        }
    } onQueue:nil];
}

-(UITableView *)bottomTB {
    if (!_bottomTB) {
        _bottomTB = [UITableView new];
        _bottomTB.backgroundColor = UIColorFromRGB(0xf2f7f5);
        
        UINib *nib = [UINib nibWithNibName:@"OneTableViewCell" bundle:nil];
        [_bottomTB registerNib:nib forCellReuseIdentifier:@"OneTableViewCell"];

        UINib *nib1 = [UINib nibWithNibName:@"TwoTableViewCell" bundle:nil];
        [_bottomTB registerNib:nib1 forCellReuseIdentifier:@"TwoTableViewCell"];
        
        
        
        _bottomTB.dataSource = self;
        _bottomTB.delegate = self;
       
        

        
        
    }
    return _bottomTB;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 15;
    }else if (indexPath.row == 3){
        return 15;
    }else{
        return 70;

    }
   }
//动画
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
         [[SDImageCache sharedImageCache] clearDisk];
        
        [self showHint:@"缓存清除完毕" yOffset:30.0];
    }
    else if(indexPath.row == 2) {
        
        SendFeedbackViewController *sendVC = [[SendFeedbackViewController alloc] init];
        
//        [self.navigationController pushViewController:sendVC animated:YES];
        [self.tabBarController.navigationController pushViewController:sendVC animated:YES];
        
    }else if(indexPath.row == 4) {
        
        //相关协议
        ProtocolViewController *protoVC = [[ProtocolViewController alloc] init];
        
        [self.navigationController pushViewController:protoVC animated:YES];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoTableViewCell"];
        return cell;
    }
    else if (indexPath.row == 3) {
        TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoTableViewCell"];
        return cell;
    }
    else if(indexPath.row == 1){
        OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneTableViewCell"];
        cell.imageView.image = [UIImage imageNamed:@"lajitong"];
        cell.textLabel.text = @"清除缓存";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else if(indexPath.row == 2){
        OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneTableViewCell"];
        cell.imageView.image = [UIImage imageNamed:@"yijianfankui"];
        cell.textLabel.text = @"意见反馈";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else {
        OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneTableViewCell"];
        cell.imageView.image = [UIImage imageNamed:@"xiangguanxieyi"];
        cell.textLabel.text = @"相关协议";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
//    else {
//        OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneTableViewCell"];
//        cell.imageView.image = [UIImage imageNamed:@"jianchagengxin"];
//        cell.textLabel.text = @"检查更新";
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        return cell;
//    }

    
}




- (void)pioneer_navigationController:(pioneer_navigationController *)navigationController withPioneerBarButtonType:(PioneerBarButtonType)barButtonType {
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
