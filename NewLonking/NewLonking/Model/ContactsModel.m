//
//  ContactsModel.m
//  NewLonking
//
//  Created by 李健 on 14-8-26.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ContactsModel.h"

@implementation ContactsModel
@synthesize company,email,tel,eFax,website;

-(id)init
{
    self = [super init];
    if (self) {
        self.company = @"";
        self.email = @"";
        self.tel = @"";
        self.eFax = @"";
    }
    return self;
}

+ (instancetype)loadFromService:(NSDictionary *)aObj
{
    ContactsModel *model = [[ContactsModel alloc] init];
    
    NSString *obj_contactid = [aObj[@"contactid"] stringValue];
    NSString *obj_company = aObj[@"company"];
    NSString *obj_email = aObj[@"email"];
    NSString *obj_tel = aObj[@"tel"];
    NSString *obj_efax = aObj[@"efax"];
    NSString *obj_website = aObj[@"website"];
//    NSString *obj_createTime = aObj[@"createTime"];
//    NSString *obj_creator = aObj[@"creator"];
    NSString *obj_updateTime = [aObj[@"updateTime"] stringValue];
//    NSString *obj_updator = aObj[@"updator"];
    NSString *obj_valid = aObj[@"valid"];
    
    if (![VerifyHelper isEmpty:obj_contactid]) {
        model.modelId = obj_contactid;
    }
    if (![VerifyHelper isEmpty:obj_company]) {
        model.company = obj_company;
    }
    if (![VerifyHelper isEmpty:obj_email]) {
        model.email = obj_email;
    }
    if (![VerifyHelper isEmpty:obj_tel]) {
        model.tel = obj_tel;
    }
    if (![VerifyHelper isEmpty:obj_efax]) {
        model.eFax = obj_efax;
    }
    if (![VerifyHelper isEmpty:obj_updateTime]) {
        model.updateTime = obj_updateTime;
    }
    if (![VerifyHelper isEmpty:obj_valid]) {
        model.valid = obj_valid;
    }
    if (![VerifyHelper isEmpty:obj_website]) {
        model.website = obj_website;
    }
    return model;
}
@end
