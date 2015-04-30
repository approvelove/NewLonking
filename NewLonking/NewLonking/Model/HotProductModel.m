//
//  HotProductModel.m
//  NewLonking
//
//  Created by 李健 on 14-10-16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "HotProductModel.h"
#import "ResourceModel.h"

@implementation HotProductModel
@synthesize resource,orderindex;
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self; 
}

+ (instancetype)loadFromService:(NSDictionary *)aObj
{
    NSAssert(aObj !=nil, @"aObj can't be nil");
    HotProductModel *model = [[HotProductModel alloc] init];
    
    NSString *obj_hotproductid = [aObj[@"hotproductid"] stringValue];
    NSString *obj_valid = aObj[@"valid"];
    NSDictionary *obj_resource = aObj[@"resource"];
    NSString *obj_updateTime = [aObj[@"updateTime"] stringValue];
    NSString *obj_orderindex = [aObj[@"index"] stringValue];
    
    if (![VerifyHelper isEmpty:obj_hotproductid]) {
        model.modelId = obj_hotproductid;
    }
    if (![VerifyHelper isEmpty:obj_valid]) {
        model.valid = obj_valid;
    }
    if (![VerifyHelper isEmpty:obj_updateTime]) {
        model.updateTime = obj_updateTime;
    }
    if (![VerifyHelper isEmpty:obj_orderindex]) {
        model.orderindex = obj_orderindex;
    }
    if (obj_resource) {
        model.resource = [ResourceModel loadFromService:obj_resource];
    }
    return model;
}
@end
