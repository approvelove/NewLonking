//
//  LearningMaterials.m
//  NewLonking
//
//  Created by 李健 on 14-8-30.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "LearningMaterials.h"
#import "TimeHelper.h"
#import "ResourceModel.h"

@implementation LearningMaterials
@synthesize name,uploadDateStr,prepareLoad,isLoading,hasLoad,materialsUrl,subName,fileType,resource;

- (id)init
{
    self = [super init];
    if (self) {
        self.prepareLoad = NO;
        self.isLoading = NO;
        self.hasLoad = NO;
        
        self.name = @"";
        self.uploadDateStr = @"";
        self.materialsUrl = @"";
        self.subName = @"";
        self.fileType = @"";
    }
    return self;
}

+ (instancetype)loadFromService:(NSDictionary *)aObj
{
    NSAssert(aObj !=nil, @"aObj can't be nil");
    LearningMaterials *model = [[LearningMaterials alloc] init];
    
    NSString *obj_studyid = [aObj[@"studyid"] stringValue];
    NSString *obj_title = aObj[@"title"];
    NSString *obj_creator = aObj[@"creator"];
    NSString *obj_updator = aObj[@"updator"];
    NSString *obj_valid = aObj[@"valid"];
//    NSString *obj_createTime = aObj[@"createTime"];
    NSString *obj_updateTime = [aObj[@"updateTime"] stringValue];
    ResourceModel *resModel = nil;
    if (aObj[@"resource"]) {
        resModel = [ResourceModel loadFromService:aObj[@"resource"]];
        model.materialsUrl = resModel.name;
        model.fileType = resModel.type;
        model.resource = resModel;
    }
    if (![VerifyHelper isEmpty:obj_studyid]) {
        model.modelId = obj_studyid;
    }
    if (![VerifyHelper isEmpty:obj_title]) {
        model.name = obj_title;
        model.subName = obj_title;

    }
    if (![VerifyHelper isEmpty:obj_updateTime]) {
        long long updateTimeNum = [obj_updateTime longLongValue];
        model.uploadDateStr = [TimeHelper getYearMonthDayWithDate:[TimeHelper convertSecondsToDate:updateTimeNum]];
    }
    if (![VerifyHelper isEmpty:obj_creator]) {
        model.creator = obj_creator;
    }
    if (![VerifyHelper isEmpty:obj_updator]) {
        model.updator = obj_updator;
    }
    if (![VerifyHelper isEmpty:obj_valid]) {
        model.valid = obj_valid;
    }
    
    return model;
}


- (void)resetStatusWithStatus:(FileStatus)status
{
    switch (status) {
        case FileStatus_hasLoad:
            {
                self.prepareLoad = NO;
                self.isLoading = NO;
                self.hasLoad = YES;
            }
            break;
        case FileStatus_isLoading:
            {
                self.prepareLoad = NO;
                self.isLoading = YES;
                self.hasLoad = NO;
            }
            break;
        case FileStatus_Prepare:
            {
                self.prepareLoad = YES;
                self.isLoading = NO;
                self.hasLoad = NO;
            }
            break;
        default:
            break;
    }
}

- (void)resetStatusToOrigin
{
    self.prepareLoad = NO;
    self.isLoading = NO;
    self.hasLoad = NO;
}
@end
