//
//  TopicEntity.m
//  Going
//
//  Created by wxy325 on 3/5/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import "TopicEntity.h"
#import "NSDictionary+noNilValueForKey.h"
@implementation TopicEntity
- (id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        self.topicId = [dict noNilValueForKey:@"id"];
        self.userId = [dict noNilValueForKey:@"user_id"];
        self.userName = [dict noNilValueForKey:@"user_name"];
        self.content = [dict noNilValueForKey:@"content"];
        self.title = [dict noNilValueForKey:@"title"];
        NSString* timeStr = [dict noNilValueForKey:@"time"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.time = [dateFormatter dateFromString:timeStr];
        
        self.moduleType = [dict noNilValueForKey:@"type_id"];
        
        
        self.good = [dict noNilValueForKey:@"good"];
        self.gooded = [dict noNilValueForKey:@"gooded"];
        self.comment = [dict noNilValueForKey:@"feedback"];
    }
    return self;
}
@end
