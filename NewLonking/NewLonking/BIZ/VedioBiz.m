//
//  VedioBiz.m
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "VedioBiz.h"
#import "VedioModel.h"
#import "VedioDAO.h"
#import "VedioService.h"

@implementation VedioBiz

+ (NSArray *)saveVedioDicDataWithArray:(NSArray *)aArray
{
    NSAssert(aArray != nil, @"method saveVedioDicDataWithArray has failed!");
    NSMutableArray *tempAry = [@[] mutableCopy];
    [aArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        VedioModel *emModel = [VedioModel loadFromService:obj];
        if (![VedioDAO findById:emModel.modelId]) {
            if ([emModel.valid isEqualToString:@"0"]) {
                [VedioDAO save:emModel];
            }
        }
        else
        {
            if ([emModel.valid isEqualToString:@"0"]) {
                [VedioDAO update:emModel];
            }
            else
            {
                [VedioDAO deleteById:emModel.modelId];
            }
        }
        if ([emModel.valid isEqualToString:@"0"]) {
            [tempAry addObject:emModel];
        }
    }];
    return tempAry;

}

+ (void)startLoadVedioDataFromServiceWithWithTimes:(NSString *)times
{
    long long recordTimes = [times longLongValue];
    [VedioService sendRequestGetVediosWithTimes:recordTimes];
}
@end
