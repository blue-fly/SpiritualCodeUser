//
//  IndentViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/7/25.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "IndentViewController.h"
#import "OrderListCell.h"
#import "OrderDetailVC.h"
#import "IndentModel.h"
#import "Indent1Model.h"
#import "Indent2Model.h"
#import "Indent3Model.h"

@interface IndentViewController ()<pioneer_navigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (copy, nonatomic) NSString *userID;
@property (copy, nonatomic) NSString *sessionID;
@property (strong, nonatomic) UIImageView *bigImageView;
@property (strong, nonatomic) UILabel *hintLB;
@property (strong, nonatomic) UITableView *bottomTB;
@property (strong, nonatomic) NSMutableArray *dataArr;
@end

@implementation IndentViewController
{
    NSDictionary *_dicModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLB.text = @"订单列表";
    self.barButtonType = PioneerBarButtonTypeBack;
    self.pioneerDelegate = self;
    self.view.backgroundColor = UIColorFromRGB(0xf2f7f5);
    [self.view addSubview:self.bottomTB];

    [self data];
    self.bottomTB.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    [self.view addSubview:self.bigImageView];
//    [self.view addSubview:self.hintLB];
}
- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic {
    
    if (self = [super init]) {
        _dicModel = modelDic; //传值字典
    }
    return self;

}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
//    _bigImageView.sd_layout.centerXEqualToView(self.view).centerYEqualToView(self.view).widthIs(203).heightIs(203);
//    _hintLB.sd_layout.topSpaceToView(_bigImageView, 36).centerXEqualToView(self.view).widthRatioToView(self.view,0.8).heightIs(22);
    _bottomTB.sd_layout.topSpaceToView (self.view, 64).leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
    
    
}

- (void)data {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.userID = [userDefault objectForKey:@"jeesite.session.usserid"];
    
    NSUserDefaults *sessionDefault = [NSUserDefaults standardUserDefaults];
    self.sessionID = [sessionDefault objectForKey:@"jeesite.session.id"];

    NSDictionary *dic = @{@"user.id":self.userID};
    
    [[HTTPManager sharedHTTPManager] httpManager:@"http://121.42.165.80/a/sys/order/list" parameter:dic requestType:HTTPTypeForm complectionBlock:^(id responseData, NSError *error) {
        
        
//        NSString *dataString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", dataString);
        
        
        for (int i = 0; i < [responseData count]; i++) {
            NSDictionary *dic = responseData[i];
            
            IndentModel*first = [IndentModel initModelWithDictionary:dic];
           
             NSDictionary *category = dic[@"category"];
             NSDictionary *office = dic[@"office"];
             NSDictionary *article = dic[@"article"];
            
             Indent1Model*categroyss = [Indent1Model initModelWithDictionary:office];
             Indent2Model *officess = [Indent2Model initModelWithDictionary:category];
             Indent3Model *articless= [Indent3Model initModelWithDictionary:article];
            
            first.categoryModel   = categroyss;
            first.officeModel = officess;
            first.articleModel = articless;
            [self.dataArr addObject:first];
        }
        
        [self.bottomTB  reloadData];
        

        
    }];
    
    
}

-(NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}


- (UITableView *)bottomTB {
    if (!_bottomTB) {
        _bottomTB = [UITableView new];
        
        _bottomTB.delegate = self;
        _bottomTB.dataSource  =self;
        
        UINib *nib = [UINib nibWithNibName:@"OrderListCell" bundle:nil];
        [_bottomTB registerNib:nib forCellReuseIdentifier:@"OrderListCell"];
        
        
    }
    return _bottomTB;
}

- (UILabel *)hintLB {
    if (!_hintLB) {
        self.hintLB = [UILabel new];
        _hintLB.text = @"暂无相关订单, 快去下单抢优惠";
        _hintLB.font = [UIFont systemFontOfSize:20];
        _hintLB.textColor = UIColorFromRGB(0xb3b3b3);
        _hintLB.textAlignment = NSTextAlignmentCenter;
        
    }
    return _hintLB;
}

- (UIImageView *)bigImageView {
    if (!_bigImageView) {
        self.bigImageView = [UIImageView new];
        _bigImageView.image = [UIImage imageNamed:@"dingdanrenwu"];
        
    }
    return _bigImageView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListCell"];
    cell.indentModel = _dataArr[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IndentModel *hos = _dataArr[indexPath.row];
    NSMutableDictionary *stepDicModel = (NSMutableDictionary *)_dicModel;
    
    
    [stepDicModel setObject:hos forKey:NSStringFromClass([IndentModel class])];

    
    OrderDetailVC *orderVC = [OrderDetailVC new];
     self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


#pragma mark -------------协议-------------
- (void)pioneer_navigationController:(pioneer_navigationController *)navigationController withPioneerBarButtonType:(PioneerBarButtonType)barButtonType
{
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
