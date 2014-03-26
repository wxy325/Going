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
#define HOST_NAME @"169.254.189.99/going"
#define PHOTO_FOLDER @"photo/"

#define URL_USER_REGISTER @"user_register"
#define URL_USER_LOGIN @"user_login"

#define URL_GET_MODULE_TYPE_INFO @"get_type_info_id"
#define URL_MODULE_NEW_TOPIC @"type_message_insert"
#define URL_MODULE_TOPIC_LIST @"get_type_message_type_id"
#define URL_MODULE_TOPIC_ADD_COMMENT @"type_message_comment_insert"
#define URL_MODULE_TOPIC_COMMENT_LIST @"get_comment_message_id"


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
        [params setObject:SHARE_SETTING_MANAGER.currentUserInfo.sessionId forKey:@"session_id"];
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

#pragma mark - Network Client
- (MKNetworkOperation*)registerWithEmail:(NSString*)email
                                   password:(NSString*)passwd
                                       name:(NSString*)name
                                     gender:(GenderType)gender
                                        age:(NSNumber*)age
                                     school:(NSString*)school
                               onSucceed:(VoidBlock)succeedBlock
                                 onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    op = [self startOperationWithPath:URL_USER_REGISTER
                            needLogin:NO
                             paramers:@{@"email":email, @"password":passwd, @"name":name, @"gender":@(gender), @"age":age, @"school":school}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSDictionary* dict = completedOperation.responseJSON;
              UserInfo* userInfo =[[UserInfo alloc] init];
              userInfo.sessionId = dict[@"session_id"];
              userInfo.email = email;
              userInfo.name = name;
              userInfo.gender = @(gender);
              userInfo.age = age;
              userInfo.school = school;
              SHARE_SETTING_MANAGER.currentUserInfo = userInfo;
              if (succeedBlock)
              {
                  succeedBlock();
              }
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    return op;
}

- (MKNetworkOperation*)loginWithEmail:(NSString*)email
                             password:(NSString*)passwd
                            onSucceed:(VoidBlock)succeedBlock
                              onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:URL_USER_LOGIN
                            needLogin:NO
                             paramers:@{@"email":email, @"password":passwd}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSDictionary* dict = completedOperation.responseJSON;
              UserInfo* userInfo = [[UserInfo alloc] initWithDict:dict];
              SHARE_SETTING_MANAGER.currentUserInfo = userInfo;
              
              if (succeedBlock)
              {
                  succeedBlock();
              }
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    
    return op;
}

#pragma mark - Module
- (MKNetworkOperation*)getModuleTypeInfo:(ModuleType)moduleType
                               onSucceed:(void (^)(ModuleEntity* m))succeedBlock
                                 onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    op = [self startOperationWithPath:URL_GET_MODULE_TYPE_INFO needLogin:NO paramers:@{@"type_id":@(moduleType)} onSucceeded:^(MKNetworkOperation *completedOperation) {
        NSDictionary* dict = completedOperation.responseJSON;
        ModuleEntity* m = [[ModuleEntity alloc] initWithDict:dict];
        m.moduleType = @(moduleType);
        if (succeedBlock)
        {
            succeedBlock(m);
        }
    } onError:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (errorBlock)
        {
            errorBlock(error);
            
        }
    }];
    return op;
}

- (MKNetworkOperation*)moduleNewTopicTitle:(NSString*)title
                                   Content:(NSString*)content
                                      type:(ModuleType)type
                                 onSucceed:(void (^)(TopicEntity* t))succeedBlock
                                   onError:(ErrorBlock)errorBlock;
{
    MKNetworkOperation* op = nil;
    op = [self startOperationWithPath:URL_MODULE_NEW_TOPIC
                            needLogin:YES
                             paramers:@{@"title":title, @"content":content, @"type_id":@(type), @"user_name": SHARE_SETTING_MANAGER.currentUserInfo.name}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
    {
        if (succeedBlock)
        {
            NSNumber* topicId = completedOperation.responseJSON[@"id"];
            TopicEntity* t = [[TopicEntity alloc] init];
            t.title = title;
            t.topicId = topicId;
            t.userName = SHARE_SETTING_MANAGER.currentUserInfo.name;
            t.content = content;
            t.moduleType = @(type);
            t.userId = SHARE_SETTING_MANAGER.currentUserInfo.userId;
            t.time = [NSDate date];
            t.good = @0;
            t.comment = @0;
            t.gooded = @NO;
            succeedBlock(t);
        }
    }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
    {
        if (errorBlock)
        {
            errorBlock(error);
        }
        
    }];
    return op;
}

- (MKNetworkOperation*)getModuleTopicList:(ModuleType)type
                                     page:(NSNumber*)page
                                onSucceed:(ArrayBlock)succeedBlock
                                  onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:URL_MODULE_TOPIC_LIST
                            needLogin:SHARE_SETTING_MANAGER.isLogin
                             paramers:@{@"type_id":@(type), @"page":page}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSDictionary* responseDict = completedOperation.responseJSON;
              NSArray* dictArray = responseDict[@"messages"];
              NSMutableArray* returnArray = [@[] mutableCopy];
              for (NSDictionary* dict in dictArray)
              {
                  TopicEntity* topic = [[TopicEntity alloc] initWithDict:dict];
                  [returnArray addObject:topic];
              }
              if (succeedBlock)
              {
                  succeedBlock(returnArray);
              }
              
              
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    
    return op;
}

- (MKNetworkOperation*)moduleTopicAddComment:(NSNumber*)topicId
                                     content:(NSString*)content
                                   onSucceed:(void (^)(TopicCommentEntity* c))succeedBlock
                                     onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:URL_MODULE_TOPIC_ADD_COMMENT
                            needLogin:YES
                             paramers:@{@"message_id":topicId, @"content":content, @"user_name":SHARE_SETTING_MANAGER.currentUserInfo.name}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              if (succeedBlock)
              {
                  TopicCommentEntity* c = [[TopicCommentEntity alloc] init];
                  c.userName = SHARE_SETTING_MANAGER.currentUserInfo.name;
                  c.content = content;
                  c.topicId = topicId;
                  c.time = [NSDate date];
                  c.commentId = completedOperation.responseJSON[@"id"];
                  succeedBlock(c);
              }
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    
    return op;
}

- (MKNetworkOperation*)moduleTopicZan:(NSNumber*)messageId
                            onSucceed:(VoidBlock)succeedBlock
                              onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:@"message_good" needLogin:YES paramers:@{@"message_id":messageId} onSucceeded:^(MKNetworkOperation *completedOperation) {
        if (succeedBlock)
        {
            succeedBlock();
        }
    } onError:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    
    return op;
}

- (MKNetworkOperation*)moduleTopicGetCommentList:(NSNumber*)topicId
                                            page:(NSNumber*)page
                                       onSucceed:(ArrayBlock)succeedBlock
                                         onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:URL_MODULE_TOPIC_COMMENT_LIST
                            needLogin:NO
                             paramers:@{@"message_id":topicId, @"page":page}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              if (succeedBlock)
              {
                  NSDictionary* responseDict = completedOperation.responseJSON;
                  NSArray* responseArray = responseDict[@"comments"];
                  NSMutableArray* returnArray = [@[] mutableCopy];
                  for (NSDictionary* dict in responseArray)
                  {
                      TopicCommentEntity* c = [[TopicCommentEntity alloc] initWithDict:dict];
                      [returnArray addObject:c];
                  }
                  succeedBlock(returnArray);
              }
              
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    
    return op;
}
@end
