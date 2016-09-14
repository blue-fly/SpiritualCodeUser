//
//  ConfirmPayOrderViewController.m
//  WeChatPayDemo
//
//  Created by pioneer on 16/8/16.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ConfirmPayOrderViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ConfirmOrderViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "HosModel.h"
#import "Hos2Model.h"
#import "PlasticModel.h"
#import "WXApi.h"
#import "HTTPManager.h"
#import "XMLDictionary.h"
#import "ComfirmModel.h"


#pragma mark - 用于获取设备ip地址
#import "DataMD5.h"
#include <ifaddrs.h>
#include <arpa/inet.h>



@interface ConfirmPayOrderViewController ()
{
    NSDictionary *_stepDicModel;
}

@property (weak, nonatomic) IBOutlet UILabel *orderNOLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;

@property (copy, nonatomic)NSString *userID;
@property (copy, nonatomic)NSString *officeID;
@property (copy, nonatomic)NSString *articleID;
@property (copy, nonatomic)NSString *categoryID;
@property (copy, nonatomic)NSString *unitprice;
@property (copy, nonatomic)NSString *totalprice;
@property (copy, nonatomic)NSString *orderNO;
@property (nonatomic, strong) Hos2Model *hos2Model;
@property (assign, nonatomic) BOOL isHave;

@end



@implementation ConfirmPayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hos2Model = _stepDicModel[NSStringFromClass([Hos2Model class])];
    _priceLB.text = _hos2Model.appointprice;
    _orderNOLB.text = [self generateOrderNO];
    
    _isHave = nil;
    
    
    
}
- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic {
    if (self = [super init]) {
        _stepDicModel = modelDic;
        NSLog(@"tagidid  %@",[[_stepDicModel[@"Hos2Model"] categoryModel] ID]);
//        Hos2Model *hos2Model = modelDic[NSStringFromClass([Hos2Model class])];
//
//        PlasticModel *plasticModel = modelDic[NSStringFromClass([PlasticModel class])]
        ;


    }
    return self;
}

- (IBAction)blackBth:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - 产生随机字符串

//生成随机数算法 ,随机字符串，不长于32位
//微信支付API接口协议中包含字段nonce_str，主要保证签名不可预测。
//我们推荐生成随机数算法如下：调用随机数函数生成，将得到的值转换为字符串。

+ (NSString *)generateTradeNO {
    
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    
    //  srand函数是初始化随机数的种子，为接下来的rand函数调用做准备。
    //  time(0)函数返回某一特定时间的小数值。
    //  这条语句的意思就是初始化随机数种子，time函数是为了提高随机的质量（也就是减少重复）而使用的。
    
    //　srand(time(0)) 就是给这个算法一个启动种子，也就是算法的随机种子数，有这个数以后才可以产生随机数,用1970.1.1至今的秒数，初始化随机数种子。
    //　Srand是种下随机种子数，你每回种下的种子不一样，用Rand得到的随机数就不一样。为了每回种下一个不一样的种子，所以就选用Time(0)，Time(0)是得到当前时时间值（因为每时每刻时间是不一样的了）。
    
    srand(time(0)); // 此行代码有警告: 可以参照支付宝支付处理
    for (int i = 0; i < kNumber; i++) {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
+ (NSString *)fetchIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}
#pragma mark 客户端操作时候的代码 \ 但是这些步骤应该放在服务端操作

//============================================================
// V3&V4支付流程实现
// 注意:参数配置请查看服务器端Demo
// 更新时间：2015年11月20日
//============================================================

// 交易类型
#define TRADE_TYPE @"APP"

// 交易结果通知网站此处用于测试，随意填写，正式使用时填写正确网站
#define NOTIFY_URL @"http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php"

// 交易价格1表示0.01元，10表示0.1元
//#define PRICE @"1"
- (IBAction)weixinPay:(id)sender {
    
    _isHave = NO;
    [self freshBtuColor];
    

}

- (IBAction)zhifubaoPay:(id)sender {
    _isHave = YES;
    [self freshBtuColor];
}


- (void)freshBtuColor {
    if (_isHave) {
        [_weixinPay setImage:[UIImage imageNamed:@"yuankuang"] forState:UIControlStateNormal];
        [_zhifubaoPay setImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateNormal];
        
        _isHave = NO;
    } else {
        [_weixinPay setImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateNormal];
        [_zhifubaoPay setImage:[UIImage imageNamed:@"yuankuang"] forState:UIControlStateNormal];
        _isHave = YES;
    }
}




- (IBAction)finalBth:(id)sender {
    if (_isHave == NO) {
       
        [self ToGenerateOrders];
        

        Product *product = [Product new];
        product.subject = @"1";//商品名称
        product.body = @"我是测试数据";
        product.price = [_hos2Model.appointprice floatValue];
        NSString *partner = @"2088421371583004";
        NSString *seller = @"13698692223@163.com";//必须是商家的收款账号才能成功
        NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBALGxQhn0GC53ZfvVgdNXwXu/PsL5mbb4QnFULo4PONyrsY02yIC0nlsZbZRpLbV6pZVZ8ZCuthz0A9byF6I72dXK8BagGfY9Da2u3/Y9K0ioz2sVbn5OoaQOCUflPJhNkbx4xM7q1WcDKuWq1QMqyMf5LSox3JHbSJy2lWQDx9u7AgMBAAECgYB4VZBsPw+5OAaKmzaGR2GySftY0uu0Kz/ju5yje8+IMYXWGgmCj87F5tx8qxXXVq2YDQc4cfjGdsG66Mv0hA+qRSovveBYn/apnaMYkjk4udyfbwT6s0Uz5A2KL0IgS1wCJtTl11zwrykTszXX8NQV/HSAtA1Ci8XXhUbrT8JREQJBAOcsgmQTADFHwSX/raBsoI3It5ohZjBxg2lQCyXH2qaPyjuV83/nlCjo/tuNl9MlpX+zVfe/7zDN7bHcvi+Zzj8CQQDExmxae3Zfe+YGyirjLKwIfcJC96uSghXoVDyGKlitzPmMULwtFyVkwECyusBt9avp7ZOe/BOoOjkxVEp4PQuFAkEA4BLAgIf6U8odadueTDV+mm/Hp1pgVuxwWBAB/ijtwyz09TSvxXaOoejVv7JLS5reBB2sYmxkSIYSs6gnoLQQuQJBAMFSfHOs5pBKxqSXDOmiIuY4v5lRgKPw4BsgX1Ik2njub6HWU/osylUguK+f4Jxnh93MxoKk/58AjN4VBRD6UI0CQQCTT6TetvS0/YCtxBgBi2Qzp+oy2y4v9oiXULFriwWlKwDM22f9EKq5uWnx13TZYauGzpc5gdOgPGq3z0a7FqaJ";
        Order *order = [[Order alloc] init];
        order.partner = partner;
        order.sellerID = seller;
        order.outTradeNO = [self generateOrderNO]; //订单ID（由商家?自?行制定）
        order.subject = product.subject; //商品标题
        order.body = product.body; //商品描述
        order.totalFee = [NSString stringWithFormat:@"%.2f",product.price]; //商
        order.notifyURL = @"http://www.testPioneer.com"; //回调URL
        order.service = @"mobile.securitypay.pay";
        order.paymentType = @"1";
        order.inputCharset = @"utf-8";
        order.itBPay = @"30m";
        order.showURL = @"m.alipay.con";
        
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        NSString *appScheme = @"PioneerTBB";
        
        //将商品信息拼接成字符串
        NSString *orderSpec = [order description];
        NSLog(@"orderSpec = %@",orderSpec);
        //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
        id<DataSigner> signer = CreateRSADataSigner(privateKey);
        NSString *signedString = [signer signString:orderSpec];
        
        //将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = nil;
        if (signedString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @"RSA"];
            
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                //【callback处理支付结果】
                NSLog(@"reslut = %@",resultDic);
            }];
            
        } else if(_isHave == YES){
            [self freshBtuColor];
            [self ToGenerateOrders];
            //    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
            //    NSTimeInterval interval = [date timeIntervalSince1970]*1000;
            //    PayReq *request = [[PayReq alloc] init];
            //    request.partnerId = @"1376136302";
            //    request.prepayId= @"1101000000140415649af9fc314aa427";
            //    request.package = @"Sign=WXPay";
            //    request.nonceStr= @"5K8264ILTKCH16CQ2502SI8ZNMTW671S";
            //    request.timeStamp= (int)interval;
            //    request.sign= @"A706D2F32E307AE73CCC9C83B2886D6C";
            //    [WXApi sendReq:request];
            //  随机字符串变量 这里最好使用和安卓端一致的生成逻辑
            NSString *nonce_str = [[self class ]generateTradeNO];
            
            //  设备IP地址,请再wifi环境下测试,否则获取的ip地址为error,正确格式应该是8.8.8.8
            NSString *addressIP = [[self class] fetchIPAddress];
            
            //  随机产生订单号用于测试，正式使用请换成你从自己服务器获取的订单号
            NSString *orderno = [NSString stringWithFormat:@"%ld",time(0)];
            
            //  获取SIGN签名
            DataMD5 *data = [[DataMD5 alloc] initWithAppid:WX_APPID
                                                    mch_id:MCH_ID
                                                 nonce_str:nonce_str
                                                partner_id:WX_PartnerKey
                                                      body:@"充值"
                                              out_trade_no:orderno
                                                 total_fee:_hos2Model.appointprice
                                          spbill_create_ip:addressIP
                                                notify_url:NOTIFY_URL
                                                trade_type:TRADE_TYPE];
            
            // 转换成xml字符串
            NSString *string = [[data dic] XMLString];
            
            
            AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
            //这里传入的xml字符串只是形似xml，但不是正确是xml格式，需要使用AF方法进行转义
            session.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
            [session.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [session.requestSerializer setValue:WXUNIFIEDORDERURL forHTTPHeaderField:@"SOAPAction"];
            [session.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
                return string;
            }];
            [session POST:WXUNIFIEDORDERURL parameters:string progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //  输出XML数据
                NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] ;
                //  将微信返回的xml数据解析转义成字典
                NSDictionary *dic = [NSDictionary dictionaryWithXMLString:responseString];
                
                // 判断返回的许可
                if ([[dic objectForKey:@"result_code"] isEqualToString:@"SUCCESS"]
                    &&[[dic objectForKey:@"return_code"] isEqualToString:@"SUCCESS"] ) {
                    // 发起微信支付，设置参数
                    PayReq *request = [[PayReq alloc] init];
                    request.openID = [dic objectForKey:WXAPPID];
                    request.partnerId = [dic objectForKey:WXMCHID];
                    request.prepayId= [dic objectForKey:WXPREPAYID];
                    request.package = @"Sign=WXPay";
                    request.nonceStr= [dic objectForKey:WXNONCESTR];
                    // 将当前时间转化成时间戳
                    NSDate *datenow = [NSDate date];
                    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
                    UInt32 timeStamp =[timeSp intValue];
                    request.timeStamp= timeStamp;
                    // 签名加密
                    DataMD5 *md5 = [[DataMD5 alloc] init];
                    request.sign = [dic objectForKey:@"sign"];
                    request.sign=[md5 createMD5SingForPay:request.openID
                                                partnerid:request.partnerId
                                                 prepayid:request.prepayId
                                                  package:request.package
                                                 noncestr:request.nonceStr
                                                timestamp:request.timeStamp];
                    // 调用微信
                    [WXApi sendReq:request];
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSLog(@"%@",error);
            }];
#pragma mark  服务端操作微信支付 / 上述客户端操作可以忽略（仅供参考）没办法，靠后台还不如靠自己，先自己了解客户端实现支付的操作
            
            //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
            //    params[WXTOTALFEE] = @"1";
            //    params[WXEQUIPMENTIP] = [[self class] fetchIPAddress];
            //
            //    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
            //    [session POST:WXUNIFIEDORDERURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //
            //        NSLog(@"responseObject = %@",responseObject);
            //
            //        // 判断返回的许可
            //        if ([[responseObject objectForKey:@"result_code"] isEqualToString:@"SUCCESS"]
            //            &&[[responseObject objectForKey:@"return_code"] isEqualToString:@"SUCCESS"] ) {
            //
            //            // 发起微信支付，设置参数
            //            PayReq *request     = [[PayReq alloc] init];
            //            request.openID      = [responseObject objectForKey:WXAPPID];
            //            request.partnerId   = [responseObject objectForKey:WXMCHID];
            //            request.prepayId    = [responseObject objectForKey:WXPREPAYID];
            //            request.package     = @"Sign=WXPay";
            //            request.nonceStr    = [responseObject objectForKey:WXNONCESTR];
            //            request.timeStamp   = [[responseObject objectForKey:@"timestamp"] intValue];
            //            request.sign        = [responseObject objectForKey:@"sign"];
            //            // 调用微信支付
            //            [WXApi sendReq:request];
            //        }else{
            //            // 显示错误信息
            //            [LyonKeyWindow.rootViewController showHint:responseObject[@"err_code_des"]];
            //        }
            //        
            //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //        
            //        NSLog(@"%@",error);
            //    }];
        }else {
            NSLog(@"aaaaaaaaaaa");
        }

    }
    
    
    
    
}

//生成订单
- (void)ToGenerateOrders {
    
    Hos2Model *hos2Model = _stepDicModel[NSStringFromClass([Hos2Model class])];
//    HosModel *hosModel = _stepDicModel[NSStringFromClass([HosModel class])];
    PlasticModel *plasticModel = _stepDicModel[NSStringFromClass([PlasticModel class])]
    ;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //用户IDjeesite.session.usserid
    self.userID = [defaults objectForKey:@"jeesite.session.usserid"];
    
    //医院ID

     self.officeID = hos2Model.officeModel.ID;
    //产品ID
//    self.articleID = hosModel.ID;
    
    
    //类型ID
    
//    判断界面
    BOOL isMainPage = [_stepDicModel[@"isMainPage"] boolValue];
    
    self.categoryID = hos2Model.categoryModel.ID;
    self.articleID = hos2Model.ID;
    self.officeID = hos2Model.officeModel.ID;
    
    if (isMainPage) {
        self.categoryID = plasticModel.categoryModel.ID;
        //医院ID
            self.officeID = plasticModel.officeModel.ID;
        
        self.articleID = plasticModel.ID;
    }
    
    //单价
    self.unitprice = hos2Model.appointprice;
    //原价
    self.totalprice = hos2Model.appointprice;
    //订单号
    self.orderNO = _orderNOLB.text;
    
      NSString *urlString = @"http://121.42.165.80/a/sys/order/save";
    
    ComfirmModel *comformModel =  [[ComfirmModel alloc]initWithUserID:_userID andofficeID:_officeID andarticleID:_articleID andcategoryID:_categoryID andunitprice:_unitprice andtotalprice:_totalprice andorderNO:_orderNO andprocount:@"1" andorderStatus:@"0" andorderFlag:@"1" andproDesc:@"充值"];
    

     NSDictionary *param = [comformModel confirmParam];
    
    NSLog(@"param   %@",param);
    
//    NSDictionary *dic = @{@"category.id":_categoryID,@"user.id":_userID,@"office.id":_officeID,@"article.id":_articleID,@"orderNo":_orderNO,@"orderStatus":@"0",@"unitprice":@"100",@"procount":@"2",@"totalprice":@"200",@"orderFlag":@"1",@"proDesc":@"充值"};
//    
//    NSLog(@"XXXXXXXXXX%@", dic);
    
    [[HTTPManager sharedHTTPManager] httpManager:urlString parameter:param requestType:HTTPTypeForm complectionBlock:^(id responseData, NSError *error) {
        if (responseData) {
            //成功
            NSLog(@"pioneerTag %@",responseData);
//            NSLog(@"%@", responseData[@"re"])
        }
        
        
        
    }];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
//
//    [manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
    
    
//    }];


}



//订单号产生规则 年-月-日-时-分-秒-4位随机数
- (NSString *)generateOrderNO
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = @"yyyyMMddhhmmss";
    NSString *dateString = [formater stringFromDate:date];
    int randomNo = arc4random_uniform(10000);
    NSString *randomNoString = [NSString stringWithFormat:@"%.4d",randomNo];
    randomNoString = [dateString stringByAppendingString:randomNoString];
    return randomNoString;
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
