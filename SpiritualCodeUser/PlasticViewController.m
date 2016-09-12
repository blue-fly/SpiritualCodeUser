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



- (void)load_testData
    {
        
        @weakify(self);
        [[HTTPManager sharedHTTPManager] httpManager:[NSString stringWithFormat:@"http://121.42.165.80/a/noauth/cms/article/list/?category.id=%@", self.IDs] parameter:nil requestType:HTTPTypePost complectionBlock:^(id responseData, NSError *error) {
            @strongify(self);
            
            NSLog(@"pioneer   %@",responseData);
            if([responseData isKindOfClass:[NSArray class]])
            {
                
                NSLog(@"123");
            }
            
            
            
            for (int i = 0; i < [responseData count]; i++) {
                NSDictionary *dic = responseData[i];
                PlasticModel *first = [PlasticModel initModelWithDictionary:dic];
                
                first.title = dic[@"title"];
//                self.detailedViewController.headlinLb = dic[@"title"];
                
                NSDictionary *office = dic[@"office"];
                NSDictionary *category = dic[@"category"];
               
                Plastic2Model *officeModel = [Plastic2Model initModelWithDictionary:office];
                Plastic3Model *categoryModel = [Plastic3Model initModelWithDictionary:category];
                
                first.officeModel = officeModel;
            
                first.categoryModel = categoryModel;
                NSLog(@"%@", first.categoryModel.ID);
                
                [self.models addObject:first];
                
                
                
            }
            
            ModelTool *model = [_models objectAtIndex:0];
         
            [model printModelFormatAttribute];
            [self.bottTB reloadData];
            
            [SVProgressHUD dismiss];
        }];
        
        
    }

- (NSMutableArray *)models {
    if (!_models) {
        
        _models = [NSMutableArray new];
    }
    return _models;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    _headView.sd_layout.topSpaceToView(self.view,64).widthRatioToView(self.view,1).heightIs(40);
    _bottTB.sd_layout.topSpaceToView(self.view,64).leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
}

- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic {
    if (self = [super init]) {
        _stepDic = (NSMutableDictionary *)modelDic;
        
    }
    return self;

}

- (UITableView *)bottTB {
    
    if (!_bottTB) {
        self.bottTB = [UITableView new];

        
        _bottTB.rowHeight = 150;
        
        UINib *nib = [UINib nibWithNibName:@"PlasticCell" bundle:nil];
        [_bottTB registerNib:nib forCellReuseIdentifier:@"PlasticCell"];
        _bottTB.delegate = self;
        _bottTB.dataSource = self;
    }
    
    return _bottTB;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
//    return 100;
    
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlasticModel *model = _models[indexPath.row];
    NSLog(@"%@",model.title);
    
    _stepDic = [NSMutableDictionary new];
    //如果是主界面  加个字段  isMainPage
    
    [_stepDic setObject:@(true) forKey:@"isMainPage"];
    [_stepDic setObject:model forKey:NSStringFromClass([PlasticModel class])];
    
//    self.detailedViewController = [[DetailedViewController alloc]initWithDictionryWithModel:_stepDic];
    self.detailedViewController = [[InfoViewController alloc] initWithDictionryWithModel:_stepDic];
    
    
    
    
//    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:self.detailedViewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}







//返回cell方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
      
    PlasticCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlasticCell"];
    cell.plasticModel = _models[indexPath.row];
    
    
    return cell;
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
