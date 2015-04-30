//
//  EmployeeModel.m
//  NewLonking
//
//  Created by 李健 on 14-8-26.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "EmployeeModel.h"


@implementation EmployeeModel
@synthesize password,realName,email,createTime,userName;
- (id)init
{
    self = [super init];
    if (self) {
        self.updateTime = @"";
        self.password = @"";
        self.realName = @"";
        self.email = @"";
        self.userName = @"";
        self.createTime = @"";
        self.password = @"";
    }
    return self;
}

+ (instancetype)loadFromService:(NSDictionary *)aObj
{
    NSAssert(aObj !=nil, @"aObj con't be nil");
    EmployeeModel *model = [[EmployeeModel alloc] init];
    
    NSString *obj_id = [aObj[@"empid"] stringValue];
    NSString *obj_username = aObj[@"username"];
    NSString *obj_realname = aObj[@"realname"];
    NSString *obj_email = aObj[@"email"];
    NSString *obj_createTime = [aObj[@"createTime"] stringValue];
    NSString *obj_creator = aObj[@"creator"];
    NSString *obj_updateTime = [aObj[@"updateTime"] stringValue];
    NSString *obj_updator = aObj[@"updator"];
    NSString *obj_valid = aObj[@"valid"];
    NSString *obj_pwd = aObj[@"pwd"];
    
    if (![VerifyHelper isEmpty:obj_id]) {
        model.modelId = obj_id;
    }
    if (![VerifyHelper isEmpty:obj_username]) {
        model.userName = obj_username;
    }
    if (![VerifyHelper isEmpty:obj_realname]) {
        model.realName = obj_realname;
    }
    if (![VerifyHelper isEmpty:obj_email]) {
        model.email = obj_email;
    }
    if (![VerifyHelper isEmpty:obj_createTime]) {
        model.createTime = obj_createTime;
    }
    if (![VerifyHelper isEmpty:obj_creator]) {
        model.creator = obj_creator;
    }
    if (![VerifyHelper isEmpty:obj_updateTime]) {
        model.updateTime = obj_updateTime;
    }
    if (![VerifyHelper isEmpty:obj_updator]) {
        model.updator = obj_updator;
    }
    if (![VerifyHelper isEmpty:obj_valid]) {
        model.valid = obj_valid;
    }
    if (![VerifyHelper isEmpty:obj_pwd]) {
        model.password = obj_pwd;
    }
    return model;
}

@end
