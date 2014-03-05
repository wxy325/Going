//
//  UserInfo.m
//  yimo_ios
//
//  Created by wxy325 on 12/26/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import "UserInfo.h"
#import "NSDictionary+noNilValueForKey.h"
#import "NSMutableDictionary+setNoNilValueForKey.h"
@implementation UserInfo

#pragma mark - Dict
- (NSDictionary*)toDict
{
    NSMutableDictionary* dict = [@{} mutableCopy];
    [dict setNoNilValue:self.email forKey:@"email"];
    [dict setNoNilValue:self.userId forKey:@"id"];
    [dict setNoNilValue:self.name forKey:@"name"];
    [dict setNoNilValue:self.gender forKey:@"gender"];
    [dict setNoNilValue:self.age forKey:@"age"];
    [dict setNoNilValue:self.school forKey:@"school"];
    [dict setNoNilValue:self.groupNumber forKey:@"group_number"]
;
    [dict setNoNilValue:self.sessionId forKey:@"session_id"];
    [dict setNoNilValue:self.vip forKey:@"vip"];
    return dict;
}
- (id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        self.email = [dict noNilValueForKey:@"email"];
        self.userId = [dict noNilValueForKey:@"id"];
        self.name = [dict noNilValueForKey:@"name"];
        self.gender = [dict noNilValueForKey:@"gender"];
        self.age = [dict noNilValueForKey:@"age"];
        self.school = [dict noNilValueForKey:@"school"];
        self.groupNumber = [dict noNilValueForKey:@"group_number"];
        self.sessionId = [dict noNilValueForKey:@"session_id"];
        self.vip = [dict noNilValueForKey:@"vip"];
    }
    return self;
}
@end
