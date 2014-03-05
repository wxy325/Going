//
//  NSMutableDictionary+setNoNilValueForKey.m
//  Going
//
//  Created by wxy325 on 3/4/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import "NSMutableDictionary+setNoNilValueForKey.h"

@implementation NSMutableDictionary (setNoNilValueForKey)
- (void)setNoNilValue:(id)value forKey:(NSString*)key
{
    if (value)
    {
        self[key] = value;
    }
}
@end
