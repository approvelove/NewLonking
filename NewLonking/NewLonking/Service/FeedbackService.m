//
//  FeedbackService.m
//  NewLonking
//
//  Created by 李健 on 14-10-13.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "FeedbackService.h"
#import "Customers.h"
#import "FeedBackBiz.h"

@implementation FeedbackService

+ (void)sendRequestPostCustomerInformation:(Customers *)aCustomer
{
    NSAssert(aCustomer != nil, @"该对象不存在");
    NSString *urlString = [NSString stringWithFormat:@"%@customers",HOST];
    NSDictionary *paramDict = @{@"country":aCustomer.country,@"creator":aCustomer.creator,@"email":aCustomer.email,@"interested":aCustomer.interestedProductName,@"name":aCustomer.name,@"tel":aCustomer.tel,@"updator":aCustomer.updator};
    [[AFHTTPRequestOperationManager manager] POST:urlString parameters:paramDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *feedBackModelArray = @[];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            //未处理
        }
        [CommonHelper postNotification:FEEDBACK_NOTIFICATION_POST_CUSTOMERINFO userInfo:@{@"resultData":feedBackModelArray,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *feedBackModelArray = @[];
        [CommonHelper postNotification:FEEDBACK_NOTIFICATION_POST_CUSTOMERINFO userInfo:@{@"resultData":feedBackModelArray}];
    }];
}
@end
