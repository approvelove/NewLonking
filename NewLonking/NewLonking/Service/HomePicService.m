//
//  HomePicService.m
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "HomePicService.h"
#import "HomePicModel.h"
#import "HomePicBiz.h"

@implementation HomePicService

+ (void)sendRequestGetHomePicWithTimes:(long long)aTimes
{
    NSString *urlString = [NSString stringWithFormat:@"%@homepic/%lld",HOST,aTimes];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *homePicModelArray = [NSArray array];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            homePicModelArray = nil;
            homePicModelArray = [HomePicBiz saveHomePicDataWithArray:responseObject[@"resultData"]];
            if (homePicModelArray.count>0) {
                HomePicModel *lastModel = [homePicModelArray lastObject];
                NSMutableDictionary *synchronizeTable = [[HomePicBiz loadSynchronizePlist] mutableCopy];
                [synchronizeTable setValue:lastModel.updateTime forKey:@"homepic"];
                [HomePicBiz writeSynchronizeStatusToPlist:synchronizeTable];
            }
        }
        [CommonHelper postNotification:NOTIFICATION_GET_HOMEPIC userInfo:@{@"resultData":homePicModelArray,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *homePicArray = @[];
        [CommonHelper postNotification:NOTIFICATION_GET_HOMEPIC userInfo:@{@"resultData":homePicArray}];
    }];
}
@end
