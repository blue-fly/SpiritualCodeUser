//
//  PlasticViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/7/21.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "PlasticViewController.h"
#import "PlasticCell.h"
#import "DetailedViewController.h"
#import "PlasticModel.h"
#import "Plastic2Model.h"
#import "InfoViewController.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import "HosPlasticModel.h"
#import "HosPlasticTableViewCell.h"
#import "TalkViewController.h"
@interface PlasticViewController ()<UITableViewDelegate,UITableViewDataSource,pioneer_navigationControllerDelegate>
@property (strong, nonatomic) UITableView *bottTB;
//@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) NSMutableArray *models;
@property (strong, nonatomic) InfoViewController *detailedViewController;

@end

@implementation PlasticViewController
{
   NSMutableDictionary *_stepDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.barButtonType = PioneerBarButtonTypeBack;
    self.titleLB.text = @"整容";
    self.pioneerDelegate = self;
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:@"加载中"];
    
    [self load_testData];

    
    [self.view addSubview:self.bottTB];

}

- (NSMutableArray *)models {
    if (!_models) {
        
        _models = [NSMutableArray new];
    }
    return _models;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _bottTB.sd_layout.topSpaceToView(self.view,64).leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
}

- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic {
    if (self = [super init]) {
        _stepDic = (NSMutableDictionary *)modelDic;
        
    }
    return self;
    
}

- (void)load_testData
    {
        
        @weakify(self);
        [[HTTPManager sharedHTTPManager] httpManager:[NSString stringWithFormat:@"http://121.42.165.80/a/noauth/sys/office/list?category.id=%@", self.IDs] parameter:nil requestType:HTTPTypePost complectionBlock:^(id responseData, NSError *error) {
            @strongify(self);
            [self.models removeAllObjects];
            [self.models addObjectsFromArray:[HosPlasticModel getModelArrayWithDictionaryArray:responseData]];
            [self performSelectorOnMainThread:@selector(update_table) withObject:nil waitUntilDone:YES];
           
        }];
        
        
    }

- (void)update_table
{
    [self.bottTB reloadData];
    [SVProgressHUD dismiss];
}


- (UITableView *)bottTB {
    
    if (!_bottTB) {
        self.bottTB = [UITableView new];
        _bottTB.rowHeight = 100;
        
        UINib *nib = [UINib nibWithNibName:@"HosPlasticTableViewCell" bundle:nil];
        [_bottTB registerNib:nib forCellReuseIdentifier:@"HosPlasticTableViewCell"];
        _bottTB.delegate = self;
        _bottTB.dataSource = self;
    }
    
    return _bottTB;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
    
}

//返回cell方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
      
    HosPlasticTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HosPlasticTableViewCell"];
    cell.hosPlasticModel = _models[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HosPlasticModel *model = _models[indexPath.row];
    _stepDic = [NSMutableDictionary new];
    //如果是主界面  加个字段  isMainPage
    [_stepDic setObject:@(true) forKey:@"isMainPage"];
    
    [_stepDic setObject:model forKey:NSStringFromClass([HosPlasticModel class])];
    
    TalkViewController *talkVC = [[TalkViewController alloc] initWithConversationChatter:model.primaryPersonID conversationType:eConversationTypeChat WithDictionryWithModel:_stepDic];
    [self.navigationController pushViewController:talkVC animated:YES];
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
