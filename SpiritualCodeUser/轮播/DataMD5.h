//
//  DataMD5.h
//  WeChatPayDemo
//
//  Created by pioneer on 16/8/16.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface DataMD5 : NSObject
@property (nonatomic,strong) NSString *appid;
@property (nonatomic,strong) NSString *mch_id;
@property (nonatomic,strong) NSString *nonce_str;
@property (nonatomic,strong) NSString *partnerkey;
@property (nonatomic,strong) NSString *body;
@property (nonatomic,strong) NSString *out_trade_no;
@property (nonatomic,strong) NSString *total_fee;
@property (nonatomic,strong) NSString *spbill_create_ip;
@property (nonatomic,strong) NSString *notify_url;
@property (nonatomic,strong) NSString *trade_type;

-(instancetype)initWithAppid:(NSString *)appid_key
                      mch_id:(NSString *)mch_id_key
                   nonce_str:(NSString *)noce_str_key
                  partner_id:(NSString *)partner_id
                        body:(NSString *)body_key
               out_trade_no :(NSString *)out_trade_no_key
                   total_fee:(NSString *)total_fee_key
            spbill_create_ip:(NSString *)spbill_create_ip_key
                  notify_url:(NSString *)notify_url_key
                  trade_type:(NSString *)trade_type_key;
-(NSString *)createMD5SingForPay:(NSString *)appid_key partnerid:(NSString *)partnerid_key prepayid:(NSString *)prepayid_key package:(NSString *)package_key noncestr:(NSString *)noncestr_key timestamp:(UInt32)timestamp_key;
- (NSMutableDictionary *)dic;
-(NSString *) md5:(NSString *)str;
@end
