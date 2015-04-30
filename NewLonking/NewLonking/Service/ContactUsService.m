//
//  ContactUsService.m
//  NewLonking
//
//  Created by 李健 on 14-10-13.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ContactUsService.h"
#import "ContactUsBiz.h"
#import "ContactsModel.h"

@implementation ContactUsService

+ (void)sendRequestGetInformationOfUs:(long long)aTimes
{
    NSString *urlString = [NSString stringWithFormat:@"%@contact/%lld",HOST,aTimes];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *contactUsAry = @[];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            contactUsAry = nil;
            contactUsAry = [ContactUsBiz saveContactUsDataWithArray:responseObject[@"resultData"]];
            if (contactUsAry.count>0) {
                ContactsModel *lastModel = [contactUsAry lastObject];
                NSMutableDictionary *synchronizeTable = [[ContactUsBiz loadSynchronizePlist] mutableCopy];
                [synchronizeTable setValue:lastModel.updateTime forKey:@"contact"];
                [ContactUsBiz writeSynchronizeStatusToPlist:synchronizeTable];
            }
        }
        [CommonHelper postNotification:CONTACTUS_NOTIFICATION_GET_CONTACTINFO userInfo:@{@"resultData":contactUsAry,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *tempAry = @[];
        [CommonHelper postNotification:CONTACTUS_NOTIFICATION_GET_CONTACTINFO userInfo:@{@"resultData":tempAry}];
    }];
}
@end
