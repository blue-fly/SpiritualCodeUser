//
//  InfoViewController.m
//  SpiritualCodeUser
//
//  Created by 段登志 on 16/9/8.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "InfoViewController.h"
#import "Masonry.h"
#import "ClickImage.h"
#import "UIControl+ActionBlocks.h"
#import "TalkViewController.h"
#import <EaseMob.h>
#import "ConfirmOrderViewController.h"

#import "Hos2Model.h"
#import "PlasticModel.h"
#import "HosPlasticModel.h"
#import "HosModel.h"
@interface InfoViewController () {
    NSDictionary *_stepDic;//传值字典
}

//内容视图，加在scrollView上面，所有其他视图需要加在这个视图上面，也实现了当内容不够的时候，界面也能有弹性滚动效果
@property (nonatomic,weak) UIView *contentView;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    //设置导航栏
    [self setUpNav];
    
    //设置滚动视图
    [self setUpScrollView];
    
    //设置填充信息
    [self setUpInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    self.view.backgroundColor = [UIColor colorWithRed:0.24 green:0.75 blue:0.82 alpha:1.00];
    self.navigationController.navigationBarHidden = YES;
}


- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic
{
    if (self = [super init]) {
        _stepDic = modelDic;
        
        NSLog(@"%@",_stepDic);
    }
    return self;
}

- (void)setUpNav {
    
    self.navigationController.navigationBarHidden = NO;

//    self.view.backgroundColor = [UIColor colorWithRed:0.24 green:0.75 blue:0.82 alpha:1.00];
    
    // 自定义导航栏左侧按钮
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 7, 30, 30);
//    leftBtn.backgroundColor = [UIColor orangeColor];
    [leftBtn setImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //中间title
    self.title = @"商品详情";
    
    self.view.backgroundColor = [UIColor colorWithRed:0.91 green:0.97 blue:0.95 alpha:1.00];
}

- (void)backClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpScrollView {
    
    //只有当scrollView的内容大于宽高才可以有滚动的效果
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor colorWithRed:0.91 green:0.97 blue:0.95 alpha:1.00];
    
    [self.infoScrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.infoScrollView);
        make.width.equalTo(self.view);
        make.height.greaterThanOrEqualTo(self.view).offset(64);
        make.bottom.equalTo(self.infoScrollView);
        
    }];
    
    self.contentView = contentView;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //手动设置滚动指示器的inserts
    self.infoScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    //手动设置ScrollView的inserts，防止内容被盖住
    self.infoScrollView.contentInset = UIEdgeInsetsMake(64, 0, 64, 0);
    
    
   }

- (void)setUpInfo {
    
    HosModel *hosmodel = _stepDic[NSStringFromClass([HosModel class])];
    Hos2Model *hos2model = _stepDic[NSStringFromClass([Hos2Model class])];
    
    //显示医院名称
    UIView *infoVC1 = [[UIView alloc] init];
    
    infoVC1.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:infoVC1];
    
    [infoVC1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.top.equalTo(@16);
        make.height.equalTo(@100);
        
    }];
    
    //医院头像
    UIImageView *headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sun"]];
    [infoVC1 addSubview:headImageView];
    
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(@30);
        make.width.height.equalTo(@50);
        
        
    }];
    
    //医院名称
    UILabel *headNameLabel = [[UILabel alloc] init];
    [infoVC1 addSubview:headNameLabel];
    
    headNameLabel.text =hosmodel.name;
    headNameLabel.font = [UIFont systemFontOfSize:16];
    
    [headNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(headImageView.mas_right).offset(10);
        make.top.equalTo(headImageView.mas_top).offset(5);
        make.width.equalTo(@200);
        
    }];
    
    //医院蜕变号
    UILabel *headIDLabel = [[UILabel alloc] init];
    [infoVC1 addSubview:headIDLabel];
    
    headIDLabel.text = @"蜕变号：123456789";
    headIDLabel.font = [UIFont systemFontOfSize:15 weight:-0.2];
    
    [headIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(headNameLabel.mas_left);
        make.top.equalTo(headNameLabel.mas_top).offset(20);
        make.width.equalTo(@200);
        
    }];
    
    //显示电话地址
    UIView *infoVC2 = [[UIView alloc] init];
    
    infoVC2.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:infoVC2];
    
    [infoVC2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(infoVC1.mas_bottom).offset(16);
        make.height.equalTo(@100);
        
    }];
    
    
    //地址
    UIButton *addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoVC2 addSubview:addressBtn];
    
    [addressBtn setImage:[UIImage imageNamed:@"zuobiao"] forState:UIControlStateNormal];
    [addressBtn setTitle:hosmodel.address forState:UIControlStateNormal];
    [addressBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [addressBtn setFont:[UIFont systemFontOfSize:15 weight:-0.15]];
    
    [addressBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@30);
        make.top.equalTo(@20);
        make.width.equalTo(self.view);
        
    }];
    
    UIView *fengeVC = [[UIView alloc] init];
    [infoVC2 addSubview:fengeVC];
    
    [fengeVC mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(@0);
        make.top.equalTo(addressBtn.mas_bottom).offset(1);
        make.height.equalTo(@2);
        
    }];
    
    
    //电话
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoVC2 addSubview:phoneBtn];
    
    [phoneBtn setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
    [phoneBtn setTitle:@"0532-67798824" forState:UIControlStateNormal];
    [phoneBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [phoneBtn setFont:[UIFont systemFontOfSize:15 weight:-0.15]];
    
    [phoneBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@30);
        make.top.equalTo(fengeVC.mas_bottom).offset(20);
        make.width.equalTo(self.view);
        
    }];
    
    
    
    //显示产品图片
    UIView *infoVC3 = [[UIView alloc] init];
    
    infoVC3.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:infoVC3];
    
    [infoVC3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(infoVC2.mas_bottom).offset(16);
        make.height.equalTo(@100);
        
    }];
    
    
    UILabel *produceLabel = [[UILabel alloc] init];
    [infoVC3 addSubview:produceLabel];
    
    produceLabel.text = @"产品图片";
    headIDLabel.font = [UIFont systemFontOfSize:17 weight:-0.2];
    
    [produceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@10);
        make.top.equalTo(@40);
        make.width.equalTo(@80);
        
    }];
    
    //产品头像
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sun"]];
    [infoVC3 addSubview:imageView];
    imageView.canClick = YES;
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(produceLabel.mas_right).offset(20);
        make.top.equalTo(@10);
        make.width.height.equalTo(@80);
        
        
    }];
    
    
    
    //显示发送信息
    UIView *infoVC4 = [[UIView alloc] init];
    
    infoVC4.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:infoVC4];
    
    [infoVC4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(infoVC3.mas_bottom).offset(16);
        make.height.equalTo(@100);
        
    }];
    
    UIButton *sendMessage = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoVC4 addSubview:sendMessage];
    
    [sendMessage setTitle:@"发送消息" forState:UIControlStateNormal];
    [sendMessage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendMessage setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    
    //点击事件
    [sendMessage handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
       
        EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:@"13285358323" conversationType:eConversationTypeChat];
        
        //    EMConversation *conversation = conversationModel.conversation;
        TalkViewController *chatController = [[TalkViewController alloc] initWithConversationChatter:conversation.chatter conversationType:conversation.conversationType];
        
        id app = [UIApplication sharedApplication].delegate;
        UINavigationController *nav =  (UINavigationController *)[app window].rootViewController;
        [nav pushViewController:chatController animated:YES];
    }];
    
    
    [sendMessage setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    [sendMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@20);
        make.top.equalTo(@20);
        make.right.equalTo(@-20);
        make.height.equalTo(@60);
    }];
    
    
    //套餐项目
    UIView *infoVC5 = [[UIView alloc] init];
    
    infoVC5.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:infoVC5];
    
    [infoVC5 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(infoVC4.mas_bottom).offset(16);
        make.height.equalTo(@100);
        
    }];
    
    //项目名称
    UILabel *subjectName = [[UILabel alloc] init];
    [infoVC5 addSubview:subjectName];
    
    subjectName.text = hos2model.title;
    headNameLabel.font = [UIFont systemFontOfSize:16 weight:1];
    
    [subjectName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(@20);
        make.width.equalTo(@300);
        
    }];
    
    UILabel *priceLable = [[UILabel alloc] init];
    [infoVC5 addSubview:priceLable];
    
    priceLable.text = [NSString stringWithFormat:@"¥ %@",hos2model.appointprice];
    priceLable.font = [UIFont systemFontOfSize:17 weight:-0.1];
    priceLable.textColor = [UIColor redColor];
    
    [priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@20);
        make.top.equalTo(subjectName.mas_bottom).offset(10);
        make.width.equalTo(@60);
        
    }];
    
    UILabel *priceLable2 = [[UILabel alloc] init];
    [infoVC5 addSubview:priceLable2];
    
//    priceLable2.text = @"￥100 ";
    priceLable2.font = [UIFont systemFontOfSize:14 weight:-0.15];
    
    
    NSString *price = @"￥100";
    NSUInteger length = [price length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:price];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(2, length-2)];
//    [attri addAttribute:NSStrikethroughColorAttributeName value:UIColorFromRGB(0x999999, 1) range:NSMakeRange(2, length-2)];
    [priceLable2 setAttributedText:attri];
    
    [priceLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(priceLable.mas_right).offset(10);
        make.top.equalTo(subjectName.mas_bottom).offset(10);
        make.width.equalTo(@40);
        
    }];
    
    
    //预订须知
    UIView *infoVC6 = [[UIView alloc] init];
    
    infoVC6.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:infoVC6];
    
    [infoVC6 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(infoVC5.mas_bottom).offset(16);
        make.height.equalTo(@400);
        
    }];
    
}

//提交订单
- (IBAction)commitBtn:(id)sender {
    ConfirmOrderViewController *conVC = [[ConfirmOrderViewController alloc] initWithDictionryWithModel:_stepDic];
    //    conVC.headLB.text = self.headlinLb.text;
    conVC.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:conVC animated:YES];
    conVC.hidesBottomBarWhenPushed =NO;

}
@end
