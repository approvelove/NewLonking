//
//  VedioModel.m
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "VedioModel.h"
#import "ResourceModel.h"
#import "LearningMaterials.h"
#import "TimeHelper.h"

@implementation VedioModel
@synthesize resource,title;

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
    VedioModel *model = [[VedioModel alloc] init];
    
    NSString *obj_vedioid = [aObj[@"vedioid"] stringValue];
    NSString *obj_valid = aObj[@"valid"];
    NSDictionary *obj_resource = aObj[@"resource"];
    NSString *obj_updateTime = [aObj[@"updateTime"] stringValue];
    NSString *obj_title = aObj[@"title"];
    NSString *obj_updator = aObj[@"updator"];
    
    if (![VerifyHelper isEmpty:obj_vedioid]) {
        model.modelId = obj_vedioid;
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
    if (![VerifyHelper isEmpty:obj_title]) {
        model.title = obj_title;
    }
    if (![VerifyHelper isEmpty:obj_updator]) {
        model.updator = obj_updator;
    }
    return model;
    
}

- (LearningMaterials *)toLearningMaterials
{
    if (self == nil) {
        return nil;
    }
    LearningMaterials *model = [[LearningMaterials alloc] init];
    if (self.resource) {
        model.materialsUrl = self.resource.name;
        model.fileType = self.resource.type;
        model.resource = self.resource;
    }
    if (![VerifyHelper isEmpty:self.modelId]) {
        model.modelId = self.modelId;
    }
    if (![VerifyHelper isEmpty:self.title]) {
        model.name = self.title;
        model.subName = self.title;
        
    }
    if (![VerifyHelper isEmpty:self.updateTime]) {
        long long updateTimeNum = [self.updateTime longLongValue];
        model.uploadDateStr = [TimeHelper getYearMonthDayWithDate:[TimeHelper convertSecondsToDate:updateTimeNum]];
    }
    if (![VerifyHelper isEmpty:self.updator]) {
        model.creator = self.updator;
    }
    if (![VerifyHelper isEmpty:self.updator]) {
        model.updator = self.updator;
    }
    if (![VerifyHelper isEmpty:self.valid]) {
        model.valid = self.valid;
    }
    return model;
}
@end
