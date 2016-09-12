//
//  DetailedViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/3.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "DetailedViewController.h"
#import "ConfirmOrderViewController.h"
#import "PlasticCell.h"

#import <UMSocialData.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialSnsService.h>
#import <UMSocialQQHandler.h>
#import <UMSocial.h>
#import "Hos2Model.h"
#import "PlasticModel.h"
#import <EaseMob.h>
#import "TalkViewController.h"

@interface DetailedViewController ()<UMSocialUIDelegate>
{
    NSString *_headName;
    NSDictionary *_stepDic;//传值字典
    
}
@property (weak, nonatomic) IBOutlet UIButton *shoucangBth;

@property (strong, nonatomic) PlasticCell *plasticCell;

@property (assign, nonatomic) NSString *userID;
@property (assign, nonatomic) NSString *officeID;
@property (assign, nonatomic) NSString *articleID;
@property (assign, nonatomic) NSString *categoryID;
@property (assign, nonatomic) BOOL isHave;

@end

@implementation DetailedViewController

- (instancetype)initWithHeadName:(NSString *)headName
{
    if (self = [super init]) {
        _headName = headName;
    
    }
    
    return self;
}


- (IBAction)telPhone:(id)sender {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"15541855117"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
   }


- (IBAction)chatBth:(id)sender {
    
    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:@"13285358323" conversationType:eConversationTypeChat];
    
//    EMConversation *conversation = conversationModel.conversation;
    TalkViewController *chatController = [[TalkViewController alloc] initWithConversationChatter:conversation.chatter conversationType:conversation.conversationType];
    
    NSLog(@"%@",conversation.chatter);
    
    
    
    id app = [UIApplication sharedApplication].delegate;
    UINavigationController *nav =  (UINavigationController *)[app window].rootViewController;
    [nav pushViewController:chatController animated:YES];}



- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic
{
    if (self = [super init]) {
        _stepDic = modelDic;
        
        Hos2Model *hos2Model = _stepDic[NSStringFromClass([Hos2Model class])];
        
//        NSLog(@"%@", hos2Model.categoryModel.ID);
            _headName = hos2Model.title;
        
        BOOL isMainPage = [modelDic[@"isMainPage"] boolValue];
        if (isMainPage) {

        
        PlasticModel *plasticModel = _stepDic[NSStringFromClass([PlasticModel class])];
        _headName = plasticModel.title;

}
    }
    return self;
}




- (void)viewWillAppear:(BOOL)animated {
       self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headlinLb.text = _headName;
    self.tabBarController.tabBar.hidden =YES;
    NSLog(@"%@", _stepDic);
    
    }


- (IBAction)fanhui:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController popViewControllerAnimated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (IBAction)tijiao:(id)sender {
    

    ConfirmOrderViewController *conVC = [[ConfirmOrderViewController alloc] initWithDictionryWithModel:_stepDic];
//    conVC.headLB.text = self.headlinLb.text;
     conVC.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:conVC animated:YES];
     conVC.hidesBottomBarWhenPushed =NO;

}

//收藏
- (IBAction)shoucangBth:(id)sender {
    
    [self freshBtuColor];

//    PlasticModel *plasticModel = _stepDic[NSStringFromClass([PlasticModel class])];
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    //用户IDjeesite.session.usserid
//    self.userID = [defaults objectForKey:@"jeesite.session.usserid"];
//    
//    self.articleID = plasticModel.ID;
//    
//    self.officeID = plasticModel.categoryModel.ID;
//    
//    self.categoryID = plasticModel.categoryModel.ID;
    
    
//    NSDictionary *dic = @{@"id":@"36"};
//    
//        
//        
//        [[HTTPManager sharedHTTPManager] httpManager:@"http://121.42.165.80/a/sys/cart/delete" parameter:dic requestType:HTTPTypeForm complectionBlock:^(id responseData, NSError *error) {
//            
//            NSLog(@"responseData %@",responseData);
//            
//        }];
//
    
}


- (void)freshBtuColor {
    
    
    PlasticModel *plasticModel = _stepDic[NSStringFromClass([PlasticModel class])];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //用户IDjeesite.session.usserid
    self.userID = [defaults objectForKey:@"jeesite.session.usserid"];
    
    self.articleID = plasticModel.ID;
    
    self.officeID = plasticModel.officeModel.ID;
    
    self.categoryID = plasticModel.categoryModel.ID;
    
    
    NSDictionary *dic1 = @{@"id":self.articleID};
    
    
    NSDictionary *dic = @{@"user.id":self.userID,@"article.id":self.articleID,@"office.id":self.officeID,@"category.id":self.categoryID};


    if (_isHave) {
        [_shoucangBth setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        
        
        [[HTTPManager sharedHTTPManager] httpManager:@"http://121.42.165.80/a/sys/cart/delete" parameter:dic1 requestType:HTTPTypeForm complectionBlock:^(id responseData, NSError *error) {
            
            
            NSLog(@"responseData %@",responseData[@"respMsg"]);
        }];

    
        _isHave = NO;
        
    } else {
        
        
        [_shoucangBth setImage:[UIImage imageNamed:@"shoucang1"] forState:UIControlStateNormal];
        [[HTTPManager sharedHTTPManager] httpManager:@"http://121.42.165.80/a/sys/cart/save" parameter:dic requestType:HTTPTypeForm complectionBlock:^(id responseData, NSError *error) {
            
            NSLog(@"xxresponseData %@",responseData[@"respMsg"]);
            
        }];
        
        
        
        _isHave = YES;
    }
}


- (IBAction)fenxiang:(id)sender {
    
//    [UMSocialData defaultData].extConfig.title = @"分享的title";
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"57a8891b67e58ee737000c76"
//                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
//                                     shareImage:[UIImage imageNamed:@"icon"]
//                                shareToSnsNames:@[UMShareToWechatTimeline]
//                                       delegate:self];
    
    
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://www.baidu.com/img/bdlogo.gif"];
    [UMSocialData defaultData].extConfig.title = @"分享的title";
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57a8891b67e58ee737000c76"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline]
                                       delegate:self];


    
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
