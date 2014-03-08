//
//  WXYDataModel.h
//  yimo_ios
//
//  Created by wxy325 on 12/26/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

//Enum
#import "GenderType.h"
#import "ModuleType.h"

//Beans
#import "UserInfo.h"
#import "TopicEntity.h"
#import "ModuleEntity.h"
#import "TopicCommentEntity.h"

#import <Foundation/Foundation.h>

#define SHARE_DM [WXYDataModel shareDataModel]

@interface WXYDataModel : NSObject

+ (WXYDataModel*)shareDataModel;

@property (strong, nonatomic) NSArray* moduleTypeResourcePrefix;
@property (strong, nonatomic) NSArray* moduleTypeTitle;
@property (strong, nonatomic) NSArray* moduleTypeColor;

- (NSString*)getResourceName:(NSString*)name withModuleType:(ModuleType)type;

@end
