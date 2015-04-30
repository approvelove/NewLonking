//
//  FeedbackService.h
//  NewLonking
//
//  Created by 李健 on 14-10-13.
//  Copyright (c) 2014年 王亮. All rights reserved.
//反馈部分，用于提交客户数据，以及客户感兴趣的产品

#import "BaseService.h"

@class Customers;
@interface FeedbackService : BaseService

/**
 *	@brief	将客户提交的信息发送到服务器
 *
 *	@param 	aCustomer 	客户
 *
 *	@return	nil
 */
+ (void)sendRequestPostCustomerInformation:(Customers *)aCustomer;

@end
