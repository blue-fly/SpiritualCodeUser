//
//  OrderDetailVC.m
//  XibDemo
//
//  Created by pioneer on 16/8/14.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "OrderDetailVC.h"
#import "IndentModel.h"

@interface OrderDetailVC (){
    NSDictionary *_setModel;
}
/***********************2016年08月14日11:47:31*********************/
/****************************订单信息展示********************************/
@property (weak, nonatomic) IBOutlet UILabel *orderNoLB;        //订单号
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLB;    //订单状态
@property (weak, nonatomic) IBOutlet UILabel *orderPhoneLB;     //预定电话
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLB;      //订单时间
@property (weak, nonatomic) IBOutlet UILabel *orderMethodLB;    //支付方式
@property (weak, nonatomic) IBOutlet UILabel *officialPriceLB;  //官方价格
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLB;    //订单数量
@property (weak, nonatomic) IBOutlet UILabel *payLB;            //支付价格
@property (weak, nonatomic) IBOutlet UILabel *orderTittleLB;    //订单标题
@property (weak, nonatomic) IBOutlet UILabel *orderHospitalLB;  //订单医院
@property (weak, nonatomic) IBOutlet UILabel *priceLB;          //价格
/**********************************************************************/
@end

@implementation OrderDetailVC

- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic {
    if (self = [super init]) {
        _setModel = modelDic;
    }
    return self;
}

//order <----> model
- (instancetype)initWithOrderModel:(id)orderModel
{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     IndentModel *indentModel = _setModel[NSStringFromClass([IndentModel class])];
    
    self.orderNoLB.text = indentModel.orderNo;
    self.orderPhoneLB.text = [NSString stringWithFormat:@"%@",indentModel.phoneName];
    
    self.payLB.text = [NSString stringWithFormat:@"%@",indentModel.unitprice];
     self.officialPriceLB.text = [NSString stringWithFormat:@"%@",indentModel.totalprice];
    self.orderNumberLB.text =   [NSString stringWithFormat:@"%@",indentModel.procount];
    self.orderTittleLB.text = indentModel.articleModel.title;
    self.orderHospitalLB.text = indentModel.categoryModel.name;

    
    
//    BOOL isMainPage = [_stepDicModel[@"isMainPage"] boolValue];

    if ([indentModel.orderFlag isEqualToString:@"1" ]) {
        self.orderMethodLB.text = @"支付宝";
    }else {
        self.orderMethodLB.text = @"微信";
    }
    
    
    if ([indentModel.orderStatus isEqualToString:@"0" ]) {
        self.orderStatusLB.text = @"未支付";
    }else {
        self.orderMethodLB.text = @"已支付";
    }
    
}


- (IBAction)blackBth:(id)sender {
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
