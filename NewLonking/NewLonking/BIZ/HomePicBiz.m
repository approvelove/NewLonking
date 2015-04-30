//
//  HomePicBiz.m
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "HomePicBiz.h"
#import "HomePicModel.h"
#import "HomePicDAO.h"
#import "HomePicService.h"

@implementation HomePicBiz

+ (NSArray *)saveHomePicDataWithArray:(NSArray *)aArray
{
    NSAssert(aArray != nil, @"method saveHomePicDataWithArray has failed!");
    NSMutableArray *tempAry = [@[] mutableCopy];
    [aArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        HomePicModel *emModel = [HomePicModel loadFromService:obj];
        if (![HomePicDAO findById:emModel.modelId]) {
            if ([emModel.valid isEqualToString:@"0"]) {
                [HomePicDAO save:emModel];
            }
        }
        else
        {
            if ([emModel.valid isEqualToString:@"0"]) {
                [HomePicDAO update:emModel];
            }
            else
            {
                [HomePicDAO deleteById:emModel.modelId];
            }
        }
        if ([emModel.valid isEqualToString:@"0"]) {
            [tempAry addObject:emModel];
        }
    }];
    return tempAry;
}

+ (void)startLoadHomePicDataFromServiceWithWithTimes:(NSString *)times
{
    long long recordTimes = [times longLongValue];
    [HomePicService sendRequestGetHomePicWithTimes:recordTimes];
}
@end
