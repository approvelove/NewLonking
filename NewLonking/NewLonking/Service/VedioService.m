//
//  VedioService.m
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "VedioService.h"
#import "VedioModel.h"
#import "VedioBiz.h"

@implementation VedioService

+ (void)sendRequestGetVediosWithTimes:(long long)aTimes
{
    NSString *urlString = [NSString stringWithFormat:@"%@vedio/%lld",HOST,aTimes];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *vedioModelArray = [NSArray array];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            vedioModelArray = nil;
            vedioModelArray = [VedioBiz saveVedioDicDataWithArray:responseObject[@"resultData"]];
            if (vedioModelArray.count>0) {
                VedioModel *lastModel = [vedioModelArray lastObject];
                NSMutableDictionary *synchronizeTable = [[VedioBiz loadSynchronizePlist] mutableCopy];
                [synchronizeTable setValue:lastModel.updateTime forKey:@"vedio"];
                [VedioBiz writeSynchronizeStatusToPlist:synchronizeTable];
            }
        }
        [CommonHelper postNotification:NOTIFICATION_GET_VEDIOS userInfo:@{@"resultData":vedioModelArray,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *vedioModelArray = @[];
        [CommonHelper postNotification:NOTIFICATION_GET_VEDIOS userInfo:@{@"resultData":vedioModelArray}];
    }];

}
@end
