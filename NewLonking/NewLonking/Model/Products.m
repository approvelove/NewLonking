//
//  Products.m
//  NewLonking
//
//  Created by 李健 on 14-8-26.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "Products.h"
#import "ProductTypeModel.h"
#import "ResourceModel.h"

@implementation Products
@synthesize typeModel,name,imgModel,modelImageModel,productDataImageModel,description,orderindex;

- (id)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        self.description = @"";
    }
    return self;
}

+ (instancetype)loadFromService:(NSDictionary *)aObj
{
    NSAssert(aObj !=nil, @"aObj can't be nil");
    Products *model = [[Products alloc] init];
    
    NSString *obj_productid = [aObj[@"productid"] stringValue];
    NSString *obj_name = aObj[@"name"];
    NSDictionary *obj_type = aObj[@"type"];
    NSDictionary *obj_resource = aObj[@"resource"];
    NSDictionary *obj_vectorresource = aObj[@"vectorresource"];  //产品矢量图的资源
    NSDictionary *obj_specresource = aObj[@"specresource"];  //产品规格图的资源
    NSString *obj_updateTime = [aObj[@"updateTime"] stringValue];
    NSString *obj_valid = aObj[@"valid"];
    NSNumber *obj_orderindex = aObj[@"index"];
    
    if (![VerifyHelper isEmpty:obj_productid]) {
        model.modelId = obj_productid;
    }
    if (![VerifyHelper isEmpty:obj_name]) {
        model.name = obj_name;
    }
    if (![VerifyHelper isEmpty:obj_updateTime]) {
        model.updateTime = obj_updateTime;
    }
    if (![VerifyHelper isEmpty:obj_valid]) {
        model.valid = obj_valid;
    }
    if (obj_orderindex) {
        model.orderindex = obj_orderindex;
    }
    if (obj_type) {
        model.typeModel = [ProductTypeModel loadFromService:obj_type];
    }
    if (obj_resource) {
        model.imgModel = [ResourceModel loadFromService:obj_resource];
    }
    if (obj_vectorresource) {
        model.modelImageModel = [ResourceModel loadFromService:obj_vectorresource];
    }
    if (obj_specresource) {
        model.productDataImageModel = [ResourceModel loadFromService:obj_specresource];
    }
    
    return model;
}
@end
