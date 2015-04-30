//
//  LearningMaterialsBiz.m
//  NewLonking
//
//  Created by 李健 on 14-10-20.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "LearningMaterialsBiz.h"
#import "LearningMaterialsService.h"
#import "LearningMaterials.h"
#import "LearningMaterialsDAO.h"

@implementation LearningMaterialsBiz

+ (NSArray *)saveLearningMaterialsDataWithArray:(NSArray *)aArray
{
    NSAssert(aArray != nil, @"method saveLearningMaterialsDataWithArray has failed!");
    NSMutableArray *tempAry = [@[] mutableCopy];
    [aArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        LearningMaterials *emModel = [LearningMaterials loadFromService:obj];
        if (![LearningMaterialsDAO findById:emModel.modelId]) {
            if ([emModel.valid isEqualToString:@"0"]) {
                [LearningMaterialsDAO save:emModel];
            }
        }
        else
        {
            if ([emModel.valid isEqualToString:@"0"]) {
                [LearningMaterialsDAO update:emModel];
            }
            else
            {
                [LearningMaterialsDAO deleteById:emModel.modelId];
            }
        }
        if ([emModel.valid isEqualToString:@"0"]) {
            [tempAry addObject:emModel];
        }
    }];
    return tempAry;
}

+ (void)startLoadLearningMaterialsDataFromServiceWithWithTimes:(NSString *)times
{
    long long recordTimes = [times longLongValue];
    [LearningMaterialsService sendRequestGetLearningMaterials:recordTimes];
}

@end
