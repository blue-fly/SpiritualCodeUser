//
//  HosIntroduceViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/7/22.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "HosIntroduceViewController.h"
#import "HosIntroduceTableViewCell.h"
#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"
#import "ThirdTableViewCell.h"
#import "plasticCell.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import "OrderDetailVC.h"
#import "DetailedViewController.h"
#import "Hos2Model.h"
#import "hos22Model.h"
#import "Hos33Model.h"
@interface HosIntroduceViewController ()<pioneer_navigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,ThirdTableViewCellDelegate>
{
    NSDictionary *_stepDicModel;
}
@property (strong, nonatomic) UITableView *settingTB;  //底层视图
@property (strong, nonatomic) UIButton *collectBth; //收藏按钮
@property (strong, nonatomic) UIButton *shareBth; //分享按钮
@property (strong, nonatomic) UIButton *blackBth; //返回
@property (strong, nonatomic) ThirdTableViewCell *THcell;
@property (nonatomic, assign) CGFloat hightOfRow;
@property (assign, nonatomic) BOOL isHave;
@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation HosIntroduceViewController
- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic
{
    if (self = [super init]) {
        _stepDicModel = modelDic; //传值字典
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [self data_processing];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _hightOfRow = 120;
    self.barButtonType = PioneerBarButtonTypeBack;
    self.titleLB.text = @"医院详细";
    self.titleLB.textColor = [UIColor redColor];
    self.pioneer_navBar.backgroundColor = [UIColor whiteColor];
    
    _isHave = YES;
    
//    self.pioneer_navBar.backgroundColor = [UIColor whiteColor];
    self.pioneerDelegate = self;
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.settingTB];
    [self.pioneer_navBar addSubview:self.collectBth];
    [self.pioneer_navBar addSubview:self.shareBth];
    [self.pioneer_navBar addSubview:self.blackBth];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _settingTB.sd_layout.topSpaceToView(self.view,64).leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
    _collectBth.sd_layout.topSpaceToView(self.pioneer_navBar,5).rightSpaceToView(self.pioneer_navBar,5).bottomSpaceToView(self.pioneer_navBar,5).widthIs(30);
     _blackBth.sd_layout.topSpaceToView(self.pioneer_navBar,5).leftSpaceToView(self.pioneer_navBar,10).bottomSpaceToView(self.pioneer_navBar,5).widthEqualToHeight();
    
}

- (UIButton *)blackBth {
    if (!_blackBth) {
        self.blackBth = [UIButton buttonWithType:UIButtonTypeCustom];
        [_blackBth setImage:[UIImage imageNamed:@"Hfanhui"] forState:UIControlStateNormal];
        [_blackBth addTarget:self action:@selector(black:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _blackBth;

}
- (void)black:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)collectBth {
    if (!_collectBth) {
        self.collectBth = [UIButton buttonWithType:UIButtonTypeCustom];
      
        
        [_collectBth setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        
        [_collectBth addTarget:self action:@selector(collecA:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return _collectBth;
}


- (void)collecA:(UIButton *)sender {
    if (_isHave == NO) {
        
        [_collectBth setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        //字典需要修改
        NSDictionary *dic = @{@"patientId":@"1",@"user.id":@"82e57182e63543a8a4ac1a9f253973f0"};
        
        [[HTTPManager sharedHTTPManager] httpManager:@"http://121.42.165.80/a/sys/fav/delete" parameter:dic requestType:HTTPTypeForm complectionBlock:^(id responseData, NSError *error) {
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"jeesite.session.id"]);
            NSLog(@"%@", error);
            NSLog(@"%@",responseData);
            NSLog(@"%@",responseData[@"respMsg"]);
        }];
        

        
        
        _isHave = YES;

    }else {
        [_collectBth setImage:[UIImage imageNamed:@"shoucang1"] forState:UIControlStateNormal];

        
        
        //字典需要修改
        NSDictionary *dic = @{@"patientId":@"1",@"user.id":@"82e57182e63543a8a4ac1a9f253973f0"};
        
        [[HTTPManager sharedHTTPManager] httpManager:@"http://121.42.165.80/a/sys/fav/save" parameter:dic requestType:HTTPTypeForm complectionBlock:^(id responseData, NSError *error) {
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"jeesite.session.id"]);
            NSLog(@"%@", error);
            NSLog(@"%@",responseData);
            NSLog(@"%@",responseData[@"respMsg"]);
        }];
        

        _isHave =NO;
    }
    
    
    
}
- (void)data_processing {
    
    @weakify(self);
    [[HTTPManager sharedHTTPManager] httpManager:[NSString stringWithFormat:@"http://121.42.165.80/a/noauth/cms/article/list?office.id=%@", self.ID] parameter:nil requestType:HTTPTypePost complectionBlock:^(id responseData, NSError *error) {
          NSLog(@"pioneer %@",responseData);
        @strongify(self);
        
//        _dataArr = [Hos2Model getModelArrayWithDictionaryArray:responseData];
        
        
            for (int i = 0; i < [responseData count]; i++) {
                NSDictionary *dic = responseData[i];
               
                Hos2Model *first = [Hos2Model initModelWithDictionary:dic];
                NSDictionary *office = dic[@"office"];
                NSDictionary *category = dic[@"category"];
            
                Hos22Model *officeModel = [Hos22Model initModelWithDictionary:office];
                Hos33Model *categroyModel = [Hos33Model initModelWithDictionary:category];
                
                first.categoryModel = categroyModel;
                first.officeModel = officeModel;
                [self.dataArr addObject:first];
                
            
        }
        
        Hos2Model *model = [_dataArr firstObject];
        [model printModelFormatAttribute];

        [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:YES];
        [self.settingTB reloadData];
        
    }];
    
    
    
    
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
- (void)updateUI
{
    [self.settingTB reloadData];
}
- (UIButton *)shareBth {
    if (!_shareBth) {
        self.shareBth = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBth setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
        
    }
    return _shareBth;
}
-(UITableView *)settingTB {
    if (!_settingTB) {
        self.settingTB = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
        
        UINib *nib = [UINib nibWithNibName:@"HosIntroduceTableViewCell" bundle:nil];
        [_settingTB registerNib:nib forCellReuseIdentifier:@"HosIntroduceTableViewCell"];
        
        
        UINib *nib1 = [UINib nibWithNibName:@"FirstTableViewCell" bundle:nil];
        [_settingTB registerNib:nib1 forCellReuseIdentifier:@"FirstTableViewCell"];
        
        
        UINib *nib2 = [UINib nibWithNibName:@"SecondTableViewCell" bundle:nil];
        [_settingTB registerNib:nib2 forCellReuseIdentifier:@"SecondTableViewCell"];
        
        
        UINib *nib3 = [UINib nibWithNibName:@"ThirdTableViewCell" bundle:nil];
        [_settingTB registerNib:nib3 forCellReuseIdentifier:@"ThirdTableViewCell"];
        
        UINib *nib4 = [UINib nibWithNibName:@"PlasticCell" bundle:nil];
        
        [_settingTB registerNib:nib4 forCellReuseIdentifier:@"PlasticCell"];
        _settingTB.tableFooterView = [UIView new];
        _settingTB.delegate = self;
        _settingTB.dataSource = self;
    }
    return _settingTB;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 1){
        HosIntroduceTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"HosIntroduceTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLB.text = _nameLB;
        cell.addressLB.text = _addLB;
        [cell.phoneBth addTarget:self action:@selector(phoneBth:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;

    }
    else if (indexPath.row == 2){
        SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 4){
        SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    else if (indexPath.row == 3){
        ThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdTableViewCell"];
        if (cell.tag != 122) {
            cell.tag = 122;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.introduceLB.text = _introduceLB;
            
            cell.delegate = self;
            
            
        }
        [cell.contentView setNeedsDisplay];
        
        return cell;
    }else {
        
        PlasticCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlasticCell"];
//        cell.hos2Model = _dataArr[indexPath.row -5 ];

        return cell;
            }

    
    

    
   }


- (void)phoneBth:(UIButton *)sender {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"15541855117"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    

   }
//协议方法
- (void)thirdTableViewCellHigh:(CGFloat)text {
    _hightOfRow = text;
  
    [self.settingTB reloadData];
    [self.settingTB setNeedsDisplay];
    [self.settingTB setNeedsLayout];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArr.count + 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 180;
    }
    else if (indexPath.row == 1){
        return 100;
    }
    else if (indexPath.row == 2){
        return 10;
    }
    else if (indexPath.row == 4){
        return 10;
    }
    else if (indexPath.row == 3){
        NSLog(@"tag  %@",@(_hightOfRow));
        return _hightOfRow;
        
    }else {
        return 180;
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
    if (indexPath.row >= 5) {
        
        Hos2Model *hos = _dataArr[indexPath.row - 5];
        
        NSMutableDictionary *stepDicModel = (NSMutableDictionary *)_stepDicModel;
        
        
        [stepDicModel setObject:hos forKey:NSStringFromClass([Hos2Model class])];
        
          DetailedViewController *detaVC = [[DetailedViewController alloc]initWithDictionryWithModel:stepDicModel];
        [self.navigationController pushViewController:detaVC animated:YES];

    }
    
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
