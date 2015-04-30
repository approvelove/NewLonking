//
//  FeedBackBiz.m
//  NewLonking
//
//  Created by 李健 on 14-10-20.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "FeedBackBiz.h"
#import "FeedbackService.h"

@implementation FeedBackBiz

+ (void)startSendCustomerInfoToServiceWithWithCustomers:(Customers *)aCustomer
{
    [FeedbackService sendRequestPostCustomerInformation:aCustomer];
}
@end
