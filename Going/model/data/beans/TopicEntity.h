//
//  TopicEntity.h
//  Going
//
//  Created by wxy325 on 3/5/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModuleType.h"

@interface TopicEntity : NSObject

@property (strong, nonatomic) NSNumber* moduleType;
@property (strong, nonatomic) NSNumber* topicId;
@property (strong, nonatomic) NSString* userName;
@property (strong, nonatomic) NSString* content;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* userId;
@property (strong, nonatomic) NSDate* time;

@property (strong, nonatomic) NSNumber* good;
@property (strong, nonatomic) NSNumber* gooded;
@property (strong, nonatomic) NSNumber* comment;


- (id)initWithDict:(NSDictionary*)dict;

@end
