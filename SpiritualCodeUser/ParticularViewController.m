//
//  ParticularViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/23.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ParticularViewController.h"

#import <UMSocialData.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialSnsService.h>
#import <UMSocialQQHandler.h>
#import <UMSocial.h>

#import "TwoTableViewCell.h"
#import "OrganizationTableViewCell.h"
#import "AddresTableViewCell.h"
#import "PhoneTableViewCell.h"
#import "PhotoTableViewCell.h"
#import "ChatTableViewCell.h"
#import "PlasticCell.h"
#import "OrganizationTableViewCell.h"
#import "HosIntroduceTableViewCell.h"
#import "PhotoCollectionViewCell.h"
#import "HosModel.h"

#import "InfoViewController.h"


@interface ParticularViewController ()<UMSocialUIDelegate>
{
    NSDictionary *_setModel;
}
@property (strong, nonatomic) UITableView *bottomTB;

@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;

@property (nonatomic, strong) UIButton *fenxiangBth;
@property (nonatomic, strong) UIButton *shoucangBth;
@property (nonatomic, assign) BOOL isHave;

@property (nonatomic, assign) NSString *userID;
@property (nonatomic, assign) NSString *patientId;

@property (nonatomic, assign) NSArray *dataArr;
@property (nonatomic, assign) NSString *officeID;


@end

@implementation ParticularViewController

- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic {
    if (self = [super init]) {
        _setModel = modelDic; //传值字典
    }
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.titleLB.text = @"机构详情";
    self.barButtonType = PioneerBarButtonTypeBack;

     self.pioneerDelegate = self;
    
    
    self.dataArr =[NSArray array];
    
    [self log_data];
    
    
    [self.view addSubview:self.bottomTB];
    [self.pioneer_navBar addSubview:self.fenxiangBth];
    [self.pioneer_navBar addSubview:self.shoucangBth];
    
    
    
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _bottomTB.sd_layout.topSpaceToView(self.view,64).leftEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(self.view,5);
    _fenxiangBth.sd_layout.topSpaceToView(self.pioneer_navBar,5).rightSpaceToView(self.pioneer_navBar,5).bottomSpaceToView(self.pioneer_navBar, 5).widthIs(34);
    
    _shoucangBth.sd_layout.topSpaceToView(self.pioneer_navBar,5).rightSpaceToView(self.fenxiangBth,5).bottomSpaceToView(self.pioneer_navBar, 5).widthIs(34);
    
}



- (UITableView *)bottomTB {
    if (!_bottomTB) {
        _bottomTB = [UITableView new];
        
        
    
      
        UINib *nib = [UINib nibWithNibName:@"TwoTableViewCell" bundle:nil];
        [_bottomTB registerNib:nib forCellReuseIdentifier:@"TwoTableViewCell"];
        
        UINib *nib1 = [UINib nibWithNibName:@"OrganizationTableViewCell" bundle:nil];
        [_bottomTB registerNib:nib1 forCellReuseIdentifier:@"OrganizationTableViewCell"];
        
        UINib *nib2 = [UINib nibWithNibName:@"AddresTableViewCell" bundle:nil];
        [_bottomTB registerNib:nib2 forCellReuseIdentifier:@"AddresTableViewCell"];
        
        UINib *nib3 = [UINib nibWithNibName:@"PhoneTableViewCell" bundle:nil];
        [_bottomTB registerNib:nib3 forCellReuseIdentifier:@"PhoneTableViewCell"];
        
        UINib *nib4 = [UINib nibWithNibName:@"ChatTableViewCell" bundle:nil];
        [_bottomTB registerNib:nib4 forCellReuseIdentifier:@"ChatTableViewCell"];
        
        UINib *nib5 = [UINib nibWithNibName:@"PlasticCell" bundle:nil];
        [_bottomTB registerNib:nib5 forCellReuseIdentifier:@"PlasticCell"];
        
//        UINib *nib6 = [UINib nibWithNibName:@"PhotoTableViewCell" bundle:nil];
        
        [_bottomTB registerClass:[PhotoTableViewCell class] forCellReuseIdentifier:@"PhotoTableViewCell"];

        
        _bottomTB.delegate = self;
        _bottomTB.dataSource =self;

        
        
        
        
    }
    return _bottomTB;
}

- (UIButton *)fenxiangBth {
    if (!_fenxiangBth) {
        
        self.fenxiangBth = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [_fenxiangBth setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
        
        
        [_fenxiangBth addTarget:self action:@selector(fenxiangAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _fenxiangBth;
}
- (void)fenxiangAction:(UIButton *)sender {
    
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



- (UIButton *)shoucangBth {
    if (!_shoucangBth) {
        
        self.shoucangBth = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [_shoucangBth setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        
        
        [_shoucangBth addTarget:self action:@selector(shoucangAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _shoucangBth;
}


- (void)shoucangAction:(UIButton *)sender {
    
    [self freshBtuColor];
    
    
//    HosModel *hosModel = _setModel[NSStringFromClass([HosModel class])];
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    //用户IDjeesite.session.usserid
//    self.userID = [defaults objectForKey:@"jeesite.session.usserid"];
//    
//    self.patientId = hosModel.ID;
//    
//    NSDictionary *dic = @{@"user.id":self.userID,@"patientId":self.patientId};
//    
////    NSDictionary *dic1 = @{@"user.id":self.userID};
//    
//        [[HTTPManager sharedHTTPManager] httpManager:@"http://121.42.165.80/a/sys/fav/save" parameter:dic requestType:HTTPTypeForm complectionBlock:^(id responseData, NSError *error) {
//            
//            NSLog(@"responseData %@",responseData);
//            
//        }];



    
}


- (void)freshBtuColor {
    
    
     HosModel *hosModel = _setModel[NSStringFromClass([HosModel class])];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //用户IDjeesite.session.usserid
    self.userID = [defaults objectForKey:@"jeesite.session.usserid"];

    self.patientId = hosModel.ID;
    
    
    
    NSDictionary *dic = @{@"user.id":self.patientId,@"patientId":self.userID};

    if (_isHave) {
        [_shoucangBth setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        
    
      
        [[HTTPManager sharedHTTPManager] httpManager:@"http://121.42.165.80/a/sys/fav/save" parameter:dic requestType:HTTPTypeForm complectionBlock:^(id responseData, NSError *error) {
            
            NSLog(@"responseData %@",responseData);
            
        }];

        _isHave = NO;
        
    } else {
        
        [_shoucangBth setImage:[UIImage imageNamed:@"shoucang1"] forState:UIControlStateNormal];
        
       
        [[HTTPManager sharedHTTPManager] httpManager:@"http://121.42.165.80/a/sys/fav/delete" parameter:dic requestType:HTTPTypeForm complectionBlock:^(id responseData, NSError *error) {
            
        }];
        
               _isHave = YES;
    }
}

- (void)log_data {
     HosModel *hosModel = _setModel[NSStringFromClass([HosModel class])];
    self.officeID = hosModel.ID;
    
 [[HTTPManager sharedHTTPManager] httpManager:[NSString stringWithFormat:@"http://121.42.165.80/a/noauth/cms/article/list?office.id=%@",self.officeID] parameter:nil requestType:HTTPTypePost complectionBlock:^(id responseData, NSError *error) {
     
     
     
     NSLog(@"%@",responseData);
     NSLog(@"xxxxxx%@", self.officeID);
     self.dataArr = [HosModel getModelArrayWithDictionaryArray:responseData];
//
     [self performSelectorOnMainThread:@selector(redaArr) withObject:nil waitUntilDone:YES];
//
//    
//
//     NSLog(@"%@", self.dataArr);

     
     
 }];
    
    
    
    
}

- (void)redaArr {
    
     [self.bottomTB reloadData];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 2||indexPath.row ==5) {
        return 20;
    }else if (indexPath.row == 3 || indexPath.row == 4) {
        return 40;
    }else if (indexPath.row == 1 ||indexPath.row == 6 || indexPath.row == 7) {
        return 80;
    }else{
        return 150;
           }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count + 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    HosModel *hosModel = _setModel[NSStringFromClass([HosModel class])];
    
    
      if (indexPath.row == 0 || indexPath.row == 2||indexPath.row ==5) {
          TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoTableViewCell"];
          return cell;
          
      }
      else if (indexPath.row == 1) {
          OrganizationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrganizationTableViewCell"];
          cell.nameLB.text = hosModel.name;
          return cell;
      }else if (indexPath.row == 4) {
          PhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneTableViewCell"];
          return cell;
      }else if (indexPath.row == 3) {
          AddresTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddresTableViewCell"];
          [cell.addresBth setTitle:hosModel.address forState:UIControlStateNormal];
          return cell;
          
          
      }else if (indexPath.row == 7) {
          ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatTableViewCell"];
          [cell.chatBth addTarget:self action:@selector(LogButton:) forControlEvents:UIControlEventTouchUpInside];
          return cell;
          
      }else if (indexPath.row == 6) {
          
          
          static NSString *CellIdentifier = @"PhotoTableViewCell";
          
          PhotoTableViewCell *cell = (PhotoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
          
          
          if (!cell)
          {
              cell = [[PhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
          }

          return cell;
          
      }else {
          PlasticCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlasticCell"];
          return cell;

          return nil;
      }

  
}


//#pragma mark - UICollectionViewDataSource Methods
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    
//    return 16;
//}
//
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
//    
//    cell.backgroundColor = [UIColor redColor];
//    
//    return cell;
//
//}



 

- (void)LogButton:(UIButton *)sender {
     [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"666666666");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 7) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if (indexPath.row == 8) {
        InfoViewController *infoVC = [[InfoViewController alloc] init];
        
        [self.navigationController pushViewController:infoVC animated:YES];
    }
    
}
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
