//
//  TopicCommentEntity.h
//  Going
//
//  Created by wxy325 on 3/5/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicCommentEntity : NSObject

@property (strong, nonatomic) NSNumber* commentId;
@property (strong, nonatomic) NSNumber* topicId;
@property (strong, nonatomic) NSString* userName;
@property (strong, nonatomic) NSNumber* userId;
@property (strong, nonatomic) NSString* content;
@property (strong, nonatomic) NSDate* time;
@property (strong, nonatomic) NSNumber* timeStr;

- (id)initWithDict:(NSDictionary*)dict;

@end
