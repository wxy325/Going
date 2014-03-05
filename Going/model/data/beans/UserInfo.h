//
//  UserInfo.h
//  yimo_ios
//
//  Created by wxy325 on 12/26/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenderType.h"

typedef NS_ENUM(NSUInteger, WXYUserType) { WXYUserTypeAdmin = 1, WXYUserTypeWorker = 2, WXYUserTypeActivityAdmin = 3 };
@interface UserInfo : NSObject

@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* userId;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSNumber* gender;
@property (strong, nonatomic) NSNumber* age;
@property (strong, nonatomic) NSString* school;
@property (strong, nonatomic) NSNumber* groupNumber;
@property (strong, nonatomic) NSString* sessionId;
@property (strong, nonatomic) NSNumber* vip;



- (NSDictionary*)toDict;
- (id)initWithDict:(NSDictionary*)dict;

@end
