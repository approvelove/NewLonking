//
//  ActivityService.m
//  NewLonking
//
//  Created by 李健 on 14-10-13.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ActivityService.h"
#import "ActivityBiz.h"
#import "ActivitiesModel.h"

@implementation ActivityService

+ (void)sendRequestGetActivityItems:(long long)aTimes
{
    NSString *urlString = [NSString stringWithFormat:@"%@activity/%lld",HOST,aTimes];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *activityModelArray = [NSArray array];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            activityModelArray = nil;
            activityModelArray = [ActivityBiz saveActivityItemsDataWithArray:responseObject[@"resultData"]];
            if (activityModelArray.count>0) {
                ActivitiesModel *lastModel = [activityModelArray lastObject];
                NSMutableDictionary *synchronizeTable = [[ActivityBiz loadSynchronizePlist] mutableCopy];  //导入时间表
                [synchronizeTable setValue:lastModel.updateTime forKey:@"activity"];   //更新时间表的时间
                [ActivityBiz writeSynchronizeStatusToPlist:synchronizeTable];
            }
        }
        [CommonHelper postNotification:ACTIVITY_NOTIFICATION_GET_ITEMS userInfo:@{@"resultData":activityModelArray,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *activityModelArray = [NSArray array];
        [CommonHelper postNotification:ACTIVITY_NOTIFICATION_GET_ITEMS userInfo:@{@"resultData":activityModelArray}];
    }];
}

+ (void)sendRequestGetActivityResources:(long long)aTimes
{
    NSString *urlString = [NSString stringWithFormat:@"%@activityres/%lld",HOST,aTimes];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *activityResourceArray = [NSArray array];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            activityResourceArray = nil;
            activityResourceArray = [ActivityBiz saveActivityResourceDataWithArray:responseObject[@"resultData"]];
            if ([responseObject[@"resultData"] count]>0) {
                NSDictionary *lastDict = [responseObject[@"resultData"] lastObject];
                NSString *timeString = [lastDict[@"updateTime"] stringValue];
                NSMutableDictionary *synchronizeTable = [[ActivityBiz loadSynchronizePlist] mutableCopy];  //导入时间表
                [synchronizeTable setValue:timeString forKey:@"activityres"]; //更新时间表的时间
                [ActivityBiz writeSynchronizeStatusToPlist:synchronizeTable];
            }
        }
        [CommonHelper postNotification:ACTIVITY_NOTIFICATION_GET_RESOURCE userInfo:@{@"resultData":activityResourceArray,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *activityResourceArray = [NSArray array];
        [CommonHelper postNotification:ACTIVITY_NOTIFICATION_GET_RESOURCE userInfo:@{@"resultData":activityResourceArray}];
    }];
}
@end
