//
//  ProductTypeModel.m
//  NewLonking
//
//  Created by 李健 on 14-10-16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ProductTypeModel.h"
#import "ResourceModel.h"

@implementation ProductTypeModel
@synthesize typeName,resource;

- (id)init
{
    self = [super init];
    if (self) {
        self.typeName = @"";
    }
    return self;
}

+ (instancetype)loadFromService:(NSDictionary *)aObj
{
    NSAssert(aObj !=nil, @"aObj can't be nil");
    ProductTypeModel *model = [[ProductTypeModel alloc] init];
    NSString *obj_producttypeid = [aObj[@"producttypeid"] stringValue];
    NSString *obj_typename = aObj[@"typename"];
    NSString *obj_updateTime = [aObj[@"updateTime"] stringValue];
    NSString *obj_valid = aObj[@"valid"];
    NSDictionary *obj_resource = aObj[@"resource"];
    
    if (![VerifyHelper isEmpty:obj_producttypeid]) {
        model.modelId = obj_producttypeid;
    }
    if (![VerifyHelper isEmpty:obj_typename]) {
        model.typeName = obj_typename;
    }
    if (![VerifyHelper isEmpty:obj_updateTime]) {
        model.updateTime = obj_updateTime;
    }
    if (![VerifyHelper isEmpty:obj_valid]) {
        model.valid = obj_valid;
    }
    if (obj_resource) {
         model.resource = [ResourceModel loadFromService:obj_resource];
    }
    return model;
}
@end
