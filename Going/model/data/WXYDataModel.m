//
//  WXYDataModel.m
//  yimo_ios
//
//  Created by wxy325 on 12/26/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import "WXYDataModel.h"

@interface WXYDataModel ()


@end

@implementation WXYDataModel

- (NSArray*)moduleTypeResourcePrefix
{
    
    if (!_moduleTypeResourcePrefix)
    {
        _moduleTypeResourcePrefix  =@[@"",@"library_",@"second_hand_", @"share_car_",@"yiqiwan_"];
    }
    return _moduleTypeResourcePrefix;
}

+ (WXYDataModel*)shareDataModel
{
    static WXYDataModel* s_DataModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_DataModel = [[WXYDataModel alloc] init];
    });
    return s_DataModel;
}

- (NSString*)getResourceName:(NSString*)name withModuleType:(ModuleType)type
{
    return [NSString stringWithFormat:@"%@%@",self.moduleTypeResourcePrefix[type],name];
}
@end
