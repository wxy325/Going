//
//  TopicCommentEntity.m
//  Going
//
//  Created by wxy325 on 3/5/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import "TopicCommentEntity.h"
#import "NSDictionary+noNilValueForKey.h"
@implementation TopicCommentEntity
- (id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        self.commentId = [dict noNilValueForKey:@"id"];
        self.userId = [dict noNilValueForKey:@"user_id"];
        self.userName = [dict noNilValueForKey:@"user_name"];
        self.content = [dict noNilValueForKey:@"content"];
#warning time未处理
        self.timeStr = [dict noNilValueForKey:@"time"];
    }
    return self;
}
@end
