//
//  ActivityBiz.m
//  NewLonking
//
//  Created by 李健 on 14-10-14.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ActivityBiz.h"
#import "ActivitiesModel.h"
#import "ActivitiesDAO.h"
#import "ActivityService.h"
#import "ActivitiesDB.h"
#import "ResourceModel.h"

@implementation ActivityBiz

+ (NSArray *)saveActivityItemsDataWithArray:(NSArray *)aArray
{
    NSAssert(aArray != nil, @"method saveAboutItemsDataWithArray has failed!");
    NSMutableArray *tempAry = [@[] mutableCopy];
    [aArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        ActivitiesModel *emModel = [ActivitiesModel loadFromService:obj];
        if (![ActivitiesDAO findById:emModel.modelId]) {
            if ([emModel.valid isEqualToString:@"0"]) {
                [ActivitiesDAO save:emModel];
            }
        }
        else
        {
            if ([emModel.valid isEqualToString:@"0"]) {
                [ActivitiesDAO update:emModel];
            }
            else
            {
                [ActivitiesDAO deleteById:emModel.modelId];
            }
        }
        if ([emModel.valid isEqualToString:@"0"]) {
            [tempAry addObject:emModel];
        }
    }];
    return tempAry;
}

+ (void)startLoadActivityItemsFromServiceWithTimes:(NSString *)times
{
    long long recordTimes = [times longLongValue];
    [ActivityService sendRequestGetActivityItems:recordTimes];
}

+ (NSArray *)saveActivityResourceDataWithArray:(NSArray *)aArray
{
    NSAssert(aArray != nil, @"method saveAboutResourceDataWithArray has failed!");
    NSArray *itemsArray = [ActivitiesDAO findAll];
    NSMutableArray *tempAry = [@[] mutableCopy];
    if (itemsArray.count>0) {
        [itemsArray enumerateObjectsUsingBlock:^(ActivitiesDB *obj, NSUInteger idx, BOOL *stop) {
            ActivitiesModel *aModel = [obj toModel];
            [aModel loadResourceArrayFromService:aArray];
            if ([aModel.valid isEqualToString:@"0"]) {
                [ActivitiesDAO update:aModel];
            }
            else
            {
                [ActivitiesDAO deleteById:aModel.modelId];
            }
            if ([aModel.valid isEqualToString:@"0"]) {
                [tempAry addObject:aModel];
            }
        }];
    }
    return tempAry;
}

+ (void)startLoadActivityResourceFromServiceWithTimes:(NSString *)times
{
    long long recordTimes = [times longLongValue];
    [ActivityService sendRequestGetActivityResources:recordTimes];
}
@end
