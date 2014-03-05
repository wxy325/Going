//
//  NSMutableDictionary+setNoNilValueForKey.h
//  Going
//
//  Created by wxy325 on 3/4/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (setNoNilValueForKey)
- (void)setNoNilValue:(id)value forKey:(NSString*)key;
@end
