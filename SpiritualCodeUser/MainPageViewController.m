//
//  MainPageViewController.m
//  SpiritualCode
//
//  Created by pioneer on 16/6/26.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "MainPageViewController.h"
#import "ExpertCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "ExpertModel.h"
#import "ExpertDetailViewController.h"
#import "PublicViewController.h"
#import "SearchViewController.h"
#import "CarousePhotoView.h"
#import "HospitalCell.h"
#import "YLSearchViewController.h"
#import "PlasticViewController.h"
#import "AdTableViewCell.h"
#import "MedicalClassifyCell.h"
#import "TLCityPickerController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "PlasticModel.h"
#import "HosIntroduceTableViewCell.h"
#import "TuibianViewController.h"
#import "ZhaomuViewController.h"
#import "ParticularViewController.h"
#import "ButtonTableViewCell.h"
#import "ExpertViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "DiscountViewController.h"

#define LocationTitleColor [UIColor colorWithRed:0 green:92.0/255 blue:1 alpha:1]
@interface MainPageViewController ()<UITableViewDataSource,UITableViewDelegate,pioneer_navigationControllerDelegate,TLCityPickerDelegate,CLLocationManagerDelegate>
//选择地点

@property (nonatomic, strong)  PlasticModel *plamodel;
@property (nonatomic,strong)  NSString * cityName;
@property (strong, nonatomic) CLLocationManager *locationManager;


@property (strong, nonatomic) UISegmentedControl *xlmm_segmentController;

//@property (strong, nonatomic) UIScrollView *controlScroll;//滑动选择
//@property (strong, nonatomic) UITableView *emotionTB;     //情感列表
//@property (strong, nonatomic) UITableView *psychologyTB;  //心理列表


@property (strong, nonatomic) UITableView *bottomTB;
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) UIButton *searchBtn;        //搜索按钮
@property (strong, nonatomic) UIButton *adButton;         //公司广告
@property (strong, nonatomic) NSArray  *dataSource;       //数据
@property (strong, nonatomic) UIButton *mapBth;           //地图按钮

@property (strong, nonatomic) UIView *headView;   //轮播图
//@property (strong, nonatomic) CarousePhotoView *carousePhotoView;
@property (strong, nonatomic) NSArray *arr;
@property (strong, nonatomic) UIImageView *headImage;   //主页标题





@end
@implementation MainPageViewController

- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pioneerDelegate = self;
    /*********************************地图选择****************************************/
    //创建CLLocationManager对象
    self.locationManager = [[CLLocationManager alloc] init];
    //设置代理为自己
    self.locationManager.delegate = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self.locationManager requestWhenInUseAuthorization];  //调用了这句,就会弹出允许框了.
    }
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager startUpdatingLocation];

    self.topView.backgroundColor = UIColorFromRGB(0x7bd9ff);
    
    self.pioneer_navBar.backgroundColor = [UIColor whiteColor];
    
//    [self load_testData];
    [self.pioneer_navBar addSubview:self.searchBtn];
//
    
    [self.view addSubview:self.bottomTB];
//    [self.bottomTB addSubview:self.headView];

    [self.pioneer_navBar addSubview:self.mapBth];
    
      
    self.bottomTB.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.controlScroll addSubview:self.emotionTB];
//    [_controlScroll addSubview:self.psychologyTB];
    
    [self.pioneer_navBar addSubview:self.headImage];
    
    
    NSLog(@"mainPage  %@",self.topView);
}
//- (void)load_testData
//{
//    NSString *destination = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    NSString *file = [destination stringByAppendingPathComponent:@"expert"];
//    _dataSource = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
//}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    
    
    _searchBtn.sd_layout.topSpaceToView(self.pioneer_navBar,10).rightSpaceToView(self.pioneer_navBar,15).bottomSpaceToView(self.pioneer_navBar,10).widthEqualToHeight(0);
    
    
    
    _bottomTB.sd_layout.topSpaceToView(self.view,64).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,49);
    
    
    _mapBth.sd_layout.topSpaceToView(self.pioneer_navBar,5).leftSpaceToView(self.pioneer_navBar,10).bottomSpaceToView(self.pioneer_navBar,5).widthIs(60);
    
    _headImage.sd_layout.centerXEqualToView(self.pioneer_navBar).centerYEqualToView(self.pioneer_navBar).widthRatioToView(self.view,0.1).heightIs(30);
}

- (UITableView *)bottomTB {
    if (!_bottomTB) {
        _bottomTB = [UITableView new];
        
        UINib *nib = [UINib nibWithNibName:@"ButtonTableViewCell" bundle:nil];
        [_bottomTB registerNib:nib forCellReuseIdentifier:@"ButtonTableViewCell"];
        
        
        UINib *nib1 = [UINib nibWithNibName:@"AdTableViewCell" bundle:nil];
        [_bottomTB registerNib:nib1 forCellReuseIdentifier:@"AdTableViewCell"];
        
        UINib *nib2 = [UINib nibWithNibName:@"MedicalClassifyCell" bundle:nil];
        [_bottomTB registerNib:nib2 forCellReuseIdentifier:@"MedicalClassifyCell"];
        
     
        _bottomTB.showsHorizontalScrollIndicator = NO;
        
        _bottomTB.delegate = self;
        _bottomTB.dataSource =self;
        
//        _bottomTB.userInteractionEnabled = NO;
        
    }
    return _bottomTB;
}

//- (UIView *)headView {
//    if (!_headView) {
//        self.headView= [UIView new];
//        _headView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
////        _headView.backgroundColor = [UIColor redColor];
//        
//        self.arr = [NSArray array];
//        self.arr = [NSArray arrayWithObjects:@"http://ww4.sinaimg.cn/large/610dc034jw1f5ufyzg2ajj20ck0kuq5e.jpg",@"http://ww3.sinaimg.cn/large/610dc034jw1f5t889dhpoj20f00mi414.jpg",@"http://ww2.sinaimg.cn/large/610dc034jw1f5s5382uokj20fk0ncmyt.jpg",@"http://ww2.sinaimg.cn/large/610dc034jw1f5qyx2wpohj20xc190tr7.jpg", nil];
//        
//        CarousePhotoView *photoView = [[CarousePhotoView alloc] initWithFrame:self.headView.bounds timeInterval:2 imageUrlArr:_arr urlArr:nil];
//        
//        [self.headView addSubview:photoView];
//
//    }
//    
//    return _headView;
//}



- (UIImageView *)headImage {
    if (!_headImage) {
        self.headImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
//        _headImage.contentMode = UIViewContentModeScaleAspectFill;

        
    }
    return _headImage;
}
- (UIButton *)mapBth {
    if (!_mapBth) {
        
        self.mapBth = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [_mapBth setTitle:@"青岛市" forState:UIControlStateNormal];
        _mapBth.tintColor= [UIColor redColor];
        
        
        [_mapBth addTarget:self action:@selector(mapbutton:) forControlEvents:UIControlEventTouchUpInside];


    }
    return _mapBth;
}

- (void)mapbutton:(UIButton *)sender {
    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
    [cityPickerVC setDelegate:self];
    
    
    cityPickerVC.loactionCityName = self.cityName;
//        cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];

}





-(UIButton *)searchBtn
{
    if(!_searchBtn){
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setImage:[UIImage imageNamed:@"bar_search"] forState:UIControlStateNormal];
        @weakify(self);
        [[_searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            //搜索
            @strongify(self);
            SearchViewController *searchVC = [SearchViewController new];
            
            
            [self.tabBarController.navigationController pushViewController:searchVC animated:YES];
        }];
    }
    return _searchBtn;
}


#pragma mark --  主页按钮





#pragma mark----------table delegate and dataSource-------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return self.bottomTB.frame.size.height*2/5;
    }else if (indexPath.row == 1) {
       return self.bottomTB.frame.size.height*1.5/5;
    }
    else {
        return self.bottomTB.frame.size.height*1.5/5;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonTableViewCell"];
        
        [cell.zhengxingBth addTarget:self action:@selector(accessAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.weizhengBth addTarget:self action:@selector(accessAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.bahenBth addTarget:self action:@selector(accessAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.meirongBth addTarget:self action:@selector(accessAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.shoushenBth addTarget:self action:@selector(accessAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.yameiBth addTarget:self action:@selector(accessAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.nanmeiBth addTarget:self action:@selector(accessAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.qudouBth addTarget:self action:@selector(accessAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.qitaBth addTarget:self action:@selector(accessAction:) forControlEvents:UIControlEventTouchUpInside];
        
        

        
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
           } else if(indexPath.row == 1){
               //
               MedicalClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MedicalClassifyCell"];
//                          [cell setDataWithModel:_dataSource[indexPath.row]];
               [cell.discountBth addTarget:self action:@selector(discountAction:) forControlEvents:UIControlEventTouchUpInside];
               cell.selectionStyle = UITableViewCellSelectionStyleNone;
               return cell;
               
    }else {

        
        AdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdTableViewCell"];
        
        [cell.tuibianBth addTarget:self action:@selector(advertisementBth:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.recruitBth addTarget:self action:@selector(advertisementBth1:) forControlEvents:UIControlEventTouchUpInside];
        cell.backgroundColor = [UIColor colorWithRed:0.916 green:0.934 blue:0.934 alpha:1.000];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;

       

    }
}

- (void)accessAction:(UIButton *)sender {
    
      PlasticViewController  *plastVC = [[PlasticViewController alloc] init];
    NSUInteger BtnTag = [sender tag];
    if (BtnTag == 1) {
        plastVC.IDs = @"22";
    }else if (BtnTag == 2) {
        
    }else if (BtnTag == 3) {
        
    }else if (BtnTag == 4) {
        
    }else if (BtnTag == 4) {
        
    }else if (BtnTag == 5) {
        
    }else if (BtnTag == 6) {
        
    }else if (BtnTag == 7) {
        
    }else if (BtnTag == 8) {
        
    }else{
        
    }

    
    [self.navigationController.tabBarController.navigationController pushViewController:plastVC animated:YES];




    
    
    
}

- (void)discountAction:(UIButton *)sender {
    DiscountViewController *discountVC = [[DiscountViewController alloc] init];
    [self.navigationController pushViewController:discountVC animated:YES];
    
    
}

- (void)advertisementBth:(UIButton *)sender{
   
        TuibianViewController *tuibianVC = [TuibianViewController new];
        [self.navigationController.tabBarController.navigationController pushViewController:tuibianVC animated:YES];
    
}

- (void)advertisementBth1:(UIButton *)sender{
    ZhaomuViewController *zhaomuVC = [ZhaomuViewController new];
    [self.navigationController.tabBarController.navigationController pushViewController:zhaomuVC animated:YES];
}

- (void)LogButton:(UIButton *)sender {
    PlasticViewController  *plastVC = [[PlasticViewController alloc] init];

    self.hidesBottomBarWhenPushed =NO;
     NSUInteger BtnTag = [sender tag];
    
    if (BtnTag == 1 ) {
        
        plastVC.IDs = @"27";
    }else if (BtnTag == 2) {
        plastVC.IDs = @"10";
    }else if (BtnTag == 3) {
        plastVC.IDs =  @"6";
    }
    else if (BtnTag == 4)
    {
               plastVC.IDs = @"18";
    }else if (BtnTag == 5){
         plastVC.IDs = @"24";
        
    }
    else {
        plastVC.IDs = @"25";
    }
   
//    self.hidesBottomBarWhenPushed  = YES;
    [self.navigationController.tabBarController.navigationController pushViewController:plastVC animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
    
}
- (void)pioneer_navigationController:(pioneer_navigationController *)navigationController withPioneerBarButtonType:(PioneerBarButtonType)barButtonType
{
    switch (barButtonType) {
        case PioneerBarButtonTypeNotify:
        {
            //公告
            PublicViewController *publicVC = [PublicViewController new];
            [self.tabBarController.navigationController pushViewController:publicVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//地点选择

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    NSLog(@"longitude = %f", ((CLLocation *)[locations
                                             lastObject]).coordinate.longitude);
    NSLog(@"latitude = %f", ((CLLocation *)[locations lastObject]).coordinate.latitude);
    
    NSLog(@"我在定位");
    
    CGFloat longitude = ((CLLocation *)[locations
                                        lastObject]).coordinate.longitude;
    CGFloat latitude = ((CLLocation *)[locations lastObject]).coordinate.latitude;
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:[locations
                                      lastObject] completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             
             
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             NSLog(@"city = %@", city);
             
             self.cityName = city;
         }
         else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }
         else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}
//定位失败，回调从方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}

- (IBAction)TLCity:(id)sender {
    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
    [cityPickerVC setDelegate:self];
    
    
    cityPickerVC.loactionCityName = self.cityName;
    //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
    
}
#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{
    NSLog(@"%@",city.cityName);
    [self.mapBth setTitle:city.cityName forState:UIControlStateNormal];
    
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
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
