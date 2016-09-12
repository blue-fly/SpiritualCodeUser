//
//  ExpertModel.h
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/10.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpertModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *specialistName;
@property (nonatomic, copy) NSString *specialty;
@property (nonatomic, copy) NSString *profile;
@property (nonatomic, copy) NSString *listProfilePicture;
@property (nonatomic, copy) NSString *userID;
- (instancetype)initWIthArray:(NSArray *)array;//用于测试
@end
