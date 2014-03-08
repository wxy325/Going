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
- (NSArray*)moduleTypeTitle
{
    if (!_moduleTypeTitle)
    {
        _moduleTypeTitle = @[@"",@"拼车 Car sharing",@"二手书 Second-hand book",@"图书馆 Library",@"一起玩 Have fun"];
    }
    return _moduleTypeTitle;
}

- (NSArray*)moduleTypeColor
{
    if (!_moduleTypeColor)
    {
        _moduleTypeColor = @[[UIColor whiteColor],
                             [UIColor colorWithRed:244/255.f green:230/255.f blue:1/255.f alpha:1.f],
                             [UIColor colorWithRed:102/255.f green:203/255.f blue:255/255.f alpha:1.f],
                             [UIColor colorWithRed:52/255.f green:204/255.f blue:153/255.f alpha:1.f],
                             [UIColor colorWithRed:254/255.f green:100/255.f blue:100/255.f alpha:1.f]
                             ];
    }
    return _moduleTypeColor;
}

- (NSArray*)moduleTypeResourcePrefix
{
    
    if (!_moduleTypeResourcePrefix)
    {
        _moduleTypeResourcePrefix  =@[@"",@"share_car_",@"second_hand_", @"library_",@"yiqiwan_"];
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
