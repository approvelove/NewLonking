//
//  LearningMaterialsService.m
//  NewLonking
//
//  Created by 李健 on 14-10-13.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "LearningMaterialsService.h"
#import "LearningMaterialsBiz.h"
#import "LearningMaterials.h"

@implementation LearningMaterialsService

+ (void)sendRequestGetLearningMaterials:(long long)aTimes
{
    NSString *urlString = [NSString stringWithFormat:@"%@study/%lld",HOST,aTimes];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *learningMaterialsModelArray = [NSArray array];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            learningMaterialsModelArray = nil;
            learningMaterialsModelArray = [LearningMaterialsBiz saveLearningMaterialsDataWithArray:responseObject[@"resultData"]];
            if (learningMaterialsModelArray.count>0) {
                LearningMaterials *lastModel = [learningMaterialsModelArray lastObject];
                NSMutableDictionary *synchronizeTable = [[LearningMaterialsBiz loadSynchronizePlist] mutableCopy];
                [synchronizeTable setValue:lastModel.updateTime forKey:@"study"];
                [LearningMaterialsBiz writeSynchronizeStatusToPlist:synchronizeTable];
            }
        }
        [CommonHelper postNotification:LEARNINGMATERIALS_NOTIFICATION_GET_LEARNINGMATERIALS userInfo:@{@"resultData":learningMaterialsModelArray,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *learningMaterialsModelArray = @[];
        [CommonHelper postNotification:LEARNINGMATERIALS_NOTIFICATION_GET_LEARNINGMATERIALS userInfo:@{@"resultData":learningMaterialsModelArray}];
    }];
}

@end
