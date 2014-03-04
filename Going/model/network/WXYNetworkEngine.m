//
//  WXYNetworoEngine.m
//  yimo_ios
//
//  Created by wxy325 on 12/26/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import "WXYNetworkEngine.h"
#import "WXYNetworkOperation.h"
#import "WXYSettingManager.h"
#import "GraphicName.h"
#import "NSDictionary+noNilValueForKey.h"

//#define HOST_NAME @"10.60.42.200:12357/YimoERP"
#define HOST_NAME @"localhost/going"


@interface WXYNetworkEngine ()
//Private Method
- (MKNetworkOperation*)startOperationWithPath:(NSString*)path
                                    needLogin:(BOOL)fLogin
                                     paramers:(NSDictionary*)paramDict
                                     dataDict:(NSDictionary*)dataDict
                                  onSucceeded:(OperationSucceedBlock)succeedBlock
                                      onError:(OperationErrorBlock)errorBlock;
- (MKNetworkOperation*)startOperationWithPath:(NSString*)path
                                    needLogin:(BOOL)fLogin
                                     paramers:(NSDictionary*)paramDict
                                  onSucceeded:(OperationSucceedBlock)succeedBlock
                                      onError:(OperationErrorBlock)errorBlock;

@end

@implementation WXYNetworkEngine
#pragma mark - Static Method
+ (WXYNetworkEngine*)shareNetworkEngine
{
    static WXYNetworkEngine* s_networkEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_networkEngine = [[WXYNetworkEngine alloc] initWithHostName:HOST_NAME];
    });
    return s_networkEngine;
}
#pragma mark - Init Method
- (id)initWithHostName:(NSString *)hostName
{
    self = [super initWithHostName:hostName];
    if (self)
    {
        [self registerOperationSubclass:[WXYNetworkOperation class]];
        [self useCache];
    }
    return self;
}
#pragma mark - Private Method
- (MKNetworkOperation*)startOperationWithPath:(NSString*)path
                                    needLogin:(BOOL)fLogin
                                     paramers:(NSDictionary*)paramDict
                                     dataDict:(NSDictionary*)dataDict
                                  onSucceeded:(OperationSucceedBlock)succeedBlock
                                      onError:(OperationErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    if (fLogin)
    {
        [params setObject:SHARE_SETTING_MANAGER.currentUserInfo.sessionId forKey:@"sessionid"];
    }
//    if (userInfo)
//    {
//        [params setValue:userInfo.accessToken forKey:@"access_token"];
//    }
    [params addEntriesFromDictionary:paramDict];
    op = [self operationWithPath:path
                          params:params
                      httpMethod:@"POST"
                             ssl:NO];
    for (NSString* key in dataDict.allKeys)
    {
        [op addData:dataDict[key] forKey:key];
    }
    
    [op addCompletionHandler:succeedBlock errorHandler:errorBlock];
    [self enqueueOperation:op forceReload:YES];
    return op;
}
- (MKNetworkOperation*)startOperationWithPath:(NSString*)path
                                    needLogin:(BOOL)fLogin
                                     paramers:(NSDictionary*)paramDict
                                  onSucceeded:(OperationSucceedBlock)succeedBlock
                                      onError:(OperationErrorBlock)errorBlock
{
    return [self startOperationWithPath:path needLogin:fLogin paramers:paramDict dataDict:nil onSucceeded:succeedBlock onError:errorBlock];
}

@end
