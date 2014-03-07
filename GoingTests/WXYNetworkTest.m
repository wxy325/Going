//
//  WXYNetworkTest.m
//  Going
//
//  Created by wxy325 on 3/4/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WXYNetworkEngine.h"
#import <GHUnitIOS/GHUnit.h>
@interface WXYNetworkTest : XCTestCase

@property (strong, nonatomic) GHAsyncTestCase* asyncTestCase;
@property (strong, nonatomic) WXYNetworkEngine* engine;

@end

@implementation WXYNetworkTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.asyncTestCase = [[GHAsyncTestCase alloc] init];
    [self.asyncTestCase setUp];
    self.engine = SHARE_NW_ENGINE;
    [self.asyncTestCase prepare];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUserRegister
{
    [self.engine registerWithEmail:@"testt@test.com" password:@"testtest" name:@"wxy" gender:GenderTypeMale age:@(10) school:@"testSchool" onSucceed:^{
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } onError:^(NSError *error) {
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}

- (void)testUserLogin
{
    [self.engine loginWithEmail:@"a@aa.com" password:@"123123" onSucceed:^{
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } onError:^(NSError *error) {
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}

- (void)testGetModuleTypeInfo
{
    [self.engine getModuleTypeInfo:1 onSucceed:^(ModuleEntity *m) {
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } onError:^(NSError *error) {
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}

- (void)testModuleNewTopic
{
    [self.engine moduleNewTopicTitle:@"title" Content:@"testContent" type:1 onSucceed:^(TopicEntity *t) {
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } onError:^(NSError *error) {
        XCTFail(@"失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];

    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}

- (void)testGetModuleTopicList
{
    [self.engine getModuleTopicList:1 page:@1 onSucceed:^(NSArray *resultArray) {
        TopicEntity* t = resultArray[0];
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } onError:^(NSError *error) {
        XCTFail(@"失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}

- (void)testTopicAddComment
{
    [self.engine moduleTopicAddComment:@1 content:@"testComment" onSucceed:^(TopicCommentEntity *c) {
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } onError:^(NSError *error) {
        XCTFail(@"失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}

- (void)testTopicGetCommentList
{
    [self.engine moduleTopicGetCommentList:@1 page:@1 onSucceed:^(NSArray *resultArray) {
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } onError:^(NSError *error) {
        XCTFail(@"失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}
@end
