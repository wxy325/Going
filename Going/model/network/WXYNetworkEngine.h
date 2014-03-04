//
//  WXYNetworoEngine.h
//  yimo_ios
//
//  Created by wxy325 on 12/26/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "WXYBlock.h"
#import "WXYDataModel.h"

#define SHARE_NW_ENGINE [WXYNetworkEngine shareNetworkEngine]

@interface WXYNetworkEngine : MKNetworkEngine

+ (WXYNetworkEngine*)shareNetworkEngine;

@end
