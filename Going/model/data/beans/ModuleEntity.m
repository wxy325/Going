//
//  ModuleEntity.m
//  Going
//
//  Created by wxy325 on 3/5/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import "ModuleEntity.h"
#import "NSDictionary+noNilValueForKey.h"
@implementation ModuleEntity

- (id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        self.moduleId = [dict noNilValueForKey:@"id"];
        self.moduleName = [dict noNilValueForKey:@"name"];
        self.moduleDescription = [dict noNilValueForKey:@"description"];
        self.image = [dict noNilValueForKey:@"img"];
    }
    return self;
}
@end
