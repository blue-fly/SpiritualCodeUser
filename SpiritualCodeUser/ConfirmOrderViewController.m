//
//  ConfirmOrderViewController.m
//  ConfirmOrderDemo
//
//  Created by pioneer on 16/8/3.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "OrderDetailVC.h"
#import "DetailedViewController.h"
#import "Hos2Model.h"
#import "HosModel.h"
#import "PlasticModel.h"
#import "ConfirmPayOrderViewController.h"
@implementation Product

@end
@interface ConfirmOrderViewController ()

{
    NSString *_headName;
    NSDictionary *_stepDicModel;
}

@property (strong, nonatomic) DetailedViewController *detailedVC;
@property (nonatomic, strong) Hos2Model *hos2Model;
@end

@implementation ConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headLB.text = _headName;
    _priceLB.text = _hos2Model.appointprice;
    _pricecyLB.text = _hos2Model.appointprice;
    _subscribePrice.text = _hos2Model.appointprice;
    [_phoneLB setTitle:_hos2Model.userPhone forState:UIControlStateNormal];

    
    }

- (instancetype)initWithHeadName:(NSString *)headName
{
    if (self = [super init]) {
        _headName = headName;
    }
    return self;
}

- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic {
    if (self = [super init]) {
        _stepDicModel = modelDic;
        self.hos2Model = modelDic[NSStringFromClass([Hos2Model class])];
        _headName = _hos2Model.title;
        
        
        BOOL isMainPage = [modelDic[@"isMainPage"] boolValue];
        if (isMainPage) {
        PlasticModel *plasticModel = modelDic[NSStringFromClass([PlasticModel class])]
        ;
        _headName = plasticModel.title;
        }
        
    }
    return self;

}


- (IBAction)返回:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}




- (IBAction)commitBth:(id)sender {
    

    
    ConfirmPayOrderViewController *orVC = [[ConfirmPayOrderViewController alloc]initWithDictionryWithModel:_stepDicModel];
//    orVC.orderNumber = [self generateTradeNO];
    NSLog(@"tagId %@",[[_stepDicModel[@"Hos2Model"] categoryModel] ID]);
    [self.navigationController pushViewController:orVC animated:YES];
}



#pragma mark   ==============产生随机订单号==============


//- (NSString *)generateTradeNO
//{
//    static int kNumber = 15;
//    
//    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//    NSMutableString *resultStr = [[NSMutableString alloc] init];
//    srand((unsigned)time(0));
//    for (int i = 0; i < kNumber; i++)
//    {
//        unsigned index = rand() % [sourceStr length];
//        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
//        [resultStr appendString:oneStr];
//    }
//    return resultStr;
//}




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
