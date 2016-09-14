//
//  MyViewController.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/18.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "MyViewController.h"
#import "OneTableViewCell.h"
#import "CollectCollectViewController.h"
#import "SetViewController.h"
#import "ShopViewController.h"
#import "InvitationViewController.h"
#import "DatumViewController.h"
#import "IndentViewController.h"
#import "IntegralViewController.h"

#import "UIColor+Image.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "LoginViewController.h"
#import <EaseMob.h>
#import <UIViewController+HUD.h>


#import "UpdateInfoViewController.h"
#import "UIImageView+WebCache.h"

#import "BeautyViewController.h"
#import "HTTPManager.h"
@interface MyViewController ()

@property (strong, nonatomic) NSArray *imageArr; //图片数组
@property (strong, nonatomic) NSArray *lableArr; //文字数组
@property (strong, nonatomic) UITableView *bottomTB;
@property (weak, nonatomic) IBOutlet UIView *updateView;

@end

@implementation MyViewController

+ (void)initialize {
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.00 green:0.77 blue:0.84 alpha:1.00]];
    
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
//    [self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColorwhiteColor],NSFontAttributeName:[UIFontboldSystemFontOfSize:17]};
}
     
- (void)viewDidLoad {
    [super viewDidLoad];
    


        self.imageArr = [NSArray arrayWithObjects:@"gouwuche",@"shoucang1", nil];
        self.lableArr = [NSArray arrayWithObjects:@"购物车",@"我的收藏", nil];

    //添加手势点击事件
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateCurrent:)];
    
    
    [self.updateView addGestureRecognizer:tapGesture];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"我的";
    
    self.headImage.layer.cornerRadius = self.headImage.width * 0.5;
    self.headImage.layer.masksToBounds = YES;
}


- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
    
    //取出头像url
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
//    NSString *url = [defaults objectForKey:@"HeadImageURL"];
    NSString *userId = [defaults objectForKey:@"jeesite.session.usserid"];
    

    
    //查出昵称
    [[HTTPManager sharedHTTPManager] httpManager:@"http://121.42.165.80/a/sys/user/get" parameter:@{@"id":userId} requestType:HTTPTypeForm complectionBlock:^(NSDictionary *responseData, NSError *error) {
        
        NSLog(@"%@",responseData);
        
        //放到主线程中
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (responseData[@"name"] != nil) {
                self.nameLB.text = responseData[@"name"];
            }
            
            
            [self.headImage sd_setImageWithURL:[NSURL URLWithString:responseData[@"photo"]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
        });
        
        
        
    }];

    
}


- (void)updateCurrent:(UITapGestureRecognizer *)gesture {
    
//    NSLog(@"这里被点击了");
    //这里点击之后跳转到修改界面
    
    UpdateInfoViewController *infoVC = [[UpdateInfoViewController alloc] initWithNibName:@"UpdateInfoViewController" bundle:nil];
    
    [self.navigationController pushViewController:infoVC animated:YES];
}


- (IBAction)setBth:(id)sender {
    SetViewController *setVC = [SetViewController new];
    [self.navigationController pushViewController:setVC animated:NO];
    
}
- (IBAction)CollectBTh:(id)sender {
    CollectCollectViewController *collectVC = [CollectCollectViewController new];
    [self.navigationController pushViewController:collectVC animated:YES];
    
}

//美丽秀
- (IBAction)showTimeBth:(id)sender {
    
    BeautyViewController *btVC = [[BeautyViewController alloc] init];
    self.navigationController.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:btVC animated:NO];
    
    
}


- (IBAction)allBTh:(id)sender {
    IndentViewController *indentVC = [IndentViewController new];
    [self.navigationController pushViewController:indentVC animated:YES];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
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
