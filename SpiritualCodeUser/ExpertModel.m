//
//  ExpertModel.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/10.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ExpertModel.h"

@implementation ExpertModel
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _displayName = [aDecoder decodeObjectForKey:@"displayName"];
        _specialistName = [aDecoder decodeObjectForKey:@"specialistName"];
        _specialty = [aDecoder decodeObjectForKey:@"specialty"];
        _profile = [aDecoder decodeObjectForKey:@"profile"];
        _listProfilePicture = [aDecoder decodeObjectForKey:@"listProfilePicture"];
        _userID = [aDecoder decodeObjectForKey:@"userID"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.displayName forKey:@"displayName"];
    [aCoder encodeObject:self.specialistName forKey:@"specialistName"];
    [aCoder encodeObject:self.specialty forKey:@"specialty"];
    [aCoder encodeObject:self.profile forKey:@"profile"];
    [aCoder encodeObject:self.listProfilePicture forKey:@"listProfilePicture"];
    [aCoder encodeObject:self.userID forKey:@"userID"];
}
- (instancetype)initWIthArray:(NSArray *)array
{
    if (self = [super init]) {
        _displayName = array[0];
        _specialistName = array[1];
        _specialty = array[2];
        _profile = array[3];
        _listProfilePicture = array[4];
        _userID = array[5];
    }
    return self;
}
@end
