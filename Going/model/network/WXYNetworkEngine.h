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

#pragma mark - Client
//Register
- (MKNetworkOperation*)registerWithEmail:(NSString*)email
                                password:(NSString*)passwd
                                    name:(NSString*)name
                                  gender:(GenderType)gender
                                     age:(NSNumber*)age
                                  school:(NSString*)school
                               onSucceed:(VoidBlock)succeedBlock
                                 onError:(ErrorBlock)errorBlock;
//Login
- (MKNetworkOperation*)loginWithEmail:(NSString*)email
                             password:(NSString*)passwd
                            onSucceed:(VoidBlock)succeedBlock
                              onError:(ErrorBlock)errorBlock;

#pragma mark - Module
//Get Info
- (MKNetworkOperation*)getModuleTypeInfo:(ModuleType)moduleType
                               onSucceed:(void (^)(ModuleEntity* m))succeedBlock
                                 onError:(ErrorBlock)errorBlock;
//New topic
- (MKNetworkOperation*)moduleNewTopicTitle:(NSString*)title
                                   Content:(NSString*)content
                                        type:(ModuleType)type
                                   onSucceed:(void (^)(TopicEntity* t))succeedBlock
                                     onError:(ErrorBlock)errorBlock;
//Topic list
- (MKNetworkOperation*)getModuleTopicList:(ModuleType)type
                                     page:(NSNumber*)page
                                onSucceed:(ArrayBlock)succeedBlock
                                  onError:(ErrorBlock)errorBlock;
//Add Comment
- (MKNetworkOperation*)moduleTopicAddComment:(NSNumber*)topicId
                                     content:(NSString*)content
                                   onSucceed:(void (^)(TopicCommentEntity* c))succeedBlock
                                     onError:(ErrorBlock)errorBlock;
//Topic Comment list
- (MKNetworkOperation*)moduleTopicGetCommentList:(NSNumber*)topicId
                                            page:(NSNumber*)page
                                       onSucceed:(ArrayBlock)succeedBlock
                                         onError:(ErrorBlock)errorBlock;
@end
