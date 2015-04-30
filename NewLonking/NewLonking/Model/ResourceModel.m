//
//  ResourceModel.m
//  NewLonking
//
//  Created by 李健 on 14-9-15.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ResourceModel.h"

@implementation ResourceModel
@synthesize name,type;

+ (instancetype)loadFromService:(NSDictionary *)aObj
{
    NSAssert(aObj != nil, @"aObj can't be nil");
    ResourceModel *model = [[ResourceModel alloc] init];
    
    //dict value
    NSString *obj_resid = [aObj[@"resid"] stringValue];
    NSString *obj_resname = aObj[@"resname"];
    NSString *obj_restype = aObj[@"restype"];
    NSString *obj_valid = aObj[@"valid"];
//    NSString *obj_creator = aObj[@"creator"];
//    NSString *obj_updator = aObj[@"updator"];
    if (![VerifyHelper isEmpty:obj_resid]) {
         model.modelId = obj_resid;
    }
    if (![VerifyHelper isEmpty:obj_resname]) {
        model.name = obj_resname;
    }
    if (![VerifyHelper isEmpty:obj_restype]) {
        model.type = obj_restype;
    }
    if (![VerifyHelper isEmpty:obj_valid]) {
        model.valid = obj_valid;
    }
    return model;
}
@end
