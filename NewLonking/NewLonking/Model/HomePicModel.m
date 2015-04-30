//
//  HomePicModel.m
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "HomePicModel.h"
#import "ResourceModel.h"

@implementation HomePicModel
@synthesize resource;

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
    HomePicModel *model = [[HomePicModel alloc] init];
    
    NSString *obj_homepicid = [aObj[@"homepicid"] stringValue];
    NSString *obj_valid = aObj[@"valid"];
    NSDictionary *obj_resource = aObj[@"resource"];
    NSString *obj_updateTime = [aObj[@"updateTime"] stringValue];
    
    if (![VerifyHelper isEmpty:obj_homepicid]) {
        model.modelId = obj_homepicid;
    }
    if (![VerifyHelper isEmpty:obj_valid]) {
        model.valid = obj_valid;
    }
    if (![VerifyHelper isEmpty:obj_updateTime]) {
        model.updateTime = obj_updateTime;
    }
    if (obj_resource) {
        model.resource = [ResourceModel loadFromService:obj_resource];
    }
    return model;

}
@end
