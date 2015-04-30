//
//  AboutBiz.m
//  NewLonking
//
//  Created by 李健 on 14-10-14.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "AboutBiz.h"
#import "AboutModel.h"
#import "AboutDAO.h"
#import "AboutService.h"
#import "AboutDB.h"

@implementation AboutBiz

+ (NSArray *)saveAboutItemsDataWithArray:(NSArray *)aArray
{
    NSAssert(aArray != nil, @"method saveAboutItemsDataWithArray has failed!");
    NSMutableArray *tempAry = [@[] mutableCopy];
    [aArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        AboutModel *emModel = [AboutModel loadFromService:obj];
        if (![AboutDAO findById:emModel.modelId]) {
            if ([emModel.valid isEqualToString:@"0"]) {
                [AboutDAO save:emModel];
            }
        }
        else
        {
            if ([emModel.valid isEqualToString:@"0"]) {
                [AboutDAO update:emModel];
            }
            else
            {
                [AboutDAO deleteById:emModel.modelId];
            }
        }
        if ([emModel.valid isEqualToString:@"0"]) {
            [tempAry addObject:emModel];
        }
    }];
    return tempAry;
}

+ (void)startLoadAboutItemsFromServiceWithTimes:(NSString *)times
{
    long long recordTimes = [times longLongValue];
    [AboutService sendRequestGetAboutLonkingItems:recordTimes];
}

+ (NSArray *)saveAboutResourceDataWithArray:(NSArray *)aArray
{
    NSAssert(aArray != nil, @"method saveAboutResourceDataWithArray has failed!");
    NSArray *itemsArray = [AboutDAO findAll];
    NSMutableArray *tempAry = [@[] mutableCopy];
    if (itemsArray.count>0) {
        [itemsArray enumerateObjectsUsingBlock:^(AboutDB *obj, NSUInteger idx, BOOL *stop) {
            AboutModel *aModel = [obj toModel];
            [aModel loadResourceArrayFromService:aArray];
            if ([aModel.valid isEqualToString:@"0"]) {
                [AboutDAO update:aModel];
            }
            else
            {
                [AboutDAO deleteById:aModel.modelId];
            }
            if ([aModel.valid isEqualToString:@"0"]) {
                [tempAry addObject:aModel];
            }
        }];
    }
    return tempAry;
}

+ (void)startLoadAboutResourceFromServiceWithTimes:(NSString *)times
{
    long long recordTime = [times longLongValue];
    [AboutService sendRequestGetAboutLonkingResource:recordTime];
}
@end
