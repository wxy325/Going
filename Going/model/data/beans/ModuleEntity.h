//
//  ModuleEntity.h
//  Going
//
//  Created by wxy325 on 3/5/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModuleType.h"
@interface ModuleEntity : NSObject

@property (strong, nonatomic) NSNumber* moduleType;
@property (strong, nonatomic) NSNumber* moduleId;
@property (strong, nonatomic) NSString* moduleName;
@property (strong, nonatomic) NSString* moduleDescription;
@property (strong, nonatomic) NSString* image;

- (id)initWithDict:(NSDictionary*)dict;

@end
