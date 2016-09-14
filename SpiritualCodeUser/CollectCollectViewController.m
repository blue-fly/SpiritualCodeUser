//
//  CollectCollectViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/7/25.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "CollectCollectViewController.h"
#import "LXSegmentScrollView.h"
#import "NameTableViewCell.h"
#import "SexTableViewCell.h"
#import "CollectModel.h"
#import "Collect1Model.h"
@interface CollectCollectViewController ()<pioneer_navigationControllerDelegate,UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
//@property (strong, nonatomic) UIScrollView *bottomView;
//@property (strong, nonatomic) LXSegmentScrollView *bottomView;
@property (strong, nonatomic) UIImageView *bigImageView;
@property (strong, nonatomic) UILabel *hintLB;
@property (strong, nonatomic) UITableView *hospitalTB;
@property (strong, nonatomic) UITableView *invitationTB;
@property (strong, nonatomic) NSMutableArray *viewArr;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSArray *dataArr;
@property (strong, nonatomic) NSArray *carArr;
@property (strong, nonatomic) NSMutableDictionary *setdic;
@end

@implementation CollectCollectViewController

- (void)viewWillAppear:(BOOL)animated {
    [self log_data];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLB.text = @"收藏";
    self.barButtonType = PioneerBarButtonTypeBack;
    self.pioneerDelegate = self;
    // Do any additional setup after loading the view from its nib.

    self.viewArr = [NSMutableArray array];
    self.dataArr = [NSArray array];
    self.carArr = [NSArray array];
    
  
    
    self.hospitalTB = [UITableView new];
    _hospitalTB.delegate = self;
    _hospitalTB.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"NameTableViewCell" bundle:nil];
    [_hospitalTB registerNib:nib forCellReuseIdentifier:@"NameTableViewCell"];
    
    [self log_data];
    
    
    
    self.invitationTB = [UITableView new];
    _invitationTB.delegate = self;
    _invitationTB.dataSource = self;
    
    UINib *nib1 = [UINib nibWithNibName:@"SexTableViewCell" bundle:nil];
    [_invitationTB registerNib:nib1 forCellReuseIdentifier:@"SexTableViewCell"];
    [self log_data];
   
    
    [self.viewArr addObject:self.hospitalTB];
    [self.viewArr addObject:self.invitationTB];



    LXSegmentScrollView *bottomView = [[LXSegmentScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) titleArray:@[@"医院",@"商品"] contentViewArray:self.viewArr];

    
    [self.view addSubview:bottomView];
    

}

- (void)log_data {
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //用户IDjeesite.session.usserid
    self.userID = [defaults objectForKey:@"jeesite.session.usserid"];
    
    NSDictionary *dic = @{@"user.id":self.userID};
    
    [[HTTPManager sharedHTTPManager] httpManager:@"http://121.42.165.80/a/sys/fav/list" parameter:dic requestType:HTTPTypeForm complectionBlock:^(id responseData, NSError *error) {
        
        self.dataArr = [CollectModel getModelArrayWithDictionaryArray:responseData];
        
        
////        打印所有
//        CollectModel *model = self.dataArr[0];
//        
//         [model printModelFormatAttribute];
////        
        
//        放到主线程
        [self performSelectorOnMainThread:@selector(redata) withObject:nil waitUntilDone:YES];
      

        
        NSLog(@"%@", responseData);
        
    }];

    
    [[HTTPManager sharedHTTPManager] httpManager:@"http://121.42.165.80/a/sys/cart/list" parameter:dic requestType:HTTPTypeForm complectionBlock:^(id responseData, NSError *error) {
        
        self.carArr = [Collect1Model getModelArrayWithDictionaryArray:responseData];
        
        NSLog(@"xxresponseData %@",responseData );
        
        [self.invitationTB reloadData];
    }];
    


    
    
}

- (void)redata {
      [self.hospitalTB reloadData];
}




- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.invitationTB) {
        return self.carArr.count;
    }
    return  self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  
    
    if (tableView == _hospitalTB) {
        
          CollectModel *collModel = _dataArr[indexPath.row];
        NameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameTableViewCell"];
        cell.nameText.text = collModel.officeName;
        cell.addresLB.text = collModel.patientName;
        return cell;

    }else {
        
        Collect1Model *coll1Model = _carArr[indexPath.row];
        SexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SexTableViewCell"];
        cell.nemeLB.text = coll1Model.articleTitle;
        cell.addresLB.text = coll1Model.officeName;
        cell.priceLB.text = coll1Model.articleappointprice;
        
        return cell;
    }
        
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
