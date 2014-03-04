//
//  UserInfo.h
//  yimo_ios
//
//  Created by wxy325 on 12/26/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, WXYUserType) { WXYUserTypeAdmin = 1, WXYUserTypeWorker = 2, WXYUserTypeActivityAdmin = 3 };
@interface UserInfo : NSObject<NSCoding, NSCopying>

@property (strong, nonatomic) NSString* userName;
@property (strong, nonatomic) NSString* sessionId;
@property (strong, nonatomic) NSNumber* roleId;

- (NSDictionary*)toDict;
- (id)initWithDict:(NSDictionary*)dict;

@end
