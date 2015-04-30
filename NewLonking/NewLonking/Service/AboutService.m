//
//  AboutService.m
//  NewLonking
//
//  Created by 李健 on 14-10-13.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "AboutService.h"
#import "AboutBiz.h"
#import "AboutModel.h"

@implementation AboutService

+ (void)sendRequestGetAboutLonkingItems:(long long)aTimes
{
    NSString *urlString = [NSString stringWithFormat:@"%@about/%lld",HOST,aTimes];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *aboutModelArray = [NSArray array];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            aboutModelArray = nil;
            aboutModelArray = [AboutBiz saveAboutItemsDataWithArray:responseObject[@"resultData"]];
            if (aboutModelArray.count>0) {
                AboutModel *lastModel = [aboutModelArray lastObject];
                NSMutableDictionary *synchronizeTable = [[AboutBiz loadSynchronizePlist] mutableCopy];  //导入时间表
                [synchronizeTable setValue:lastModel.updateTime forKey:@"about"];   //更新时间表的时间
                [AboutBiz writeSynchronizeStatusToPlist:synchronizeTable];
            }
        }
        [CommonHelper postNotification:ABOUT_NOTIFICATION_GET_ABOUTLONKING_ITEMS userInfo:@{@"resultData":aboutModelArray,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *aboutModelArray = @[];
        [CommonHelper postNotification:ABOUT_NOTIFICATION_GET_ABOUTLONKING_ITEMS userInfo:@{@"resultData":aboutModelArray}];
    }];
}

+ (void)sendRequestGetAboutLonkingResource:(long long)aTimes
{
    NSString *urlString = [NSString stringWithFormat:@"%@aboutres/%lld",HOST,aTimes];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *aboutResourceArray = [NSArray array];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            aboutResourceArray = nil;
            aboutResourceArray = [AboutBiz saveAboutResourceDataWithArray:responseObject[@"resultData"]];
            if ([responseObject[@"resultData"] count]>0) {
                NSDictionary *lastDict = [responseObject[@"resultData"] lastObject];
                NSString *timeString = [lastDict[@"updateTime"] stringValue];
                NSMutableDictionary *synchronizeTable = [[AboutBiz loadSynchronizePlist] mutableCopy];  //导入时间表
                [synchronizeTable setValue:timeString forKey:@"aboutres"]; //更新时间表的时间
                [AboutBiz writeSynchronizeStatusToPlist:synchronizeTable];
            }
        }
        [CommonHelper postNotification:ABOUT_NOTIFICATION_GET_ABOUTLONKING_RESOURCE userInfo:@{@"resultData":aboutResourceArray,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *aboutResourceArray = @[];
        [CommonHelper postNotification:ABOUT_NOTIFICATION_GET_ABOUTLONKING_RESOURCE userInfo:@{@"resultData":aboutResourceArray}];
    }];
}
@end
