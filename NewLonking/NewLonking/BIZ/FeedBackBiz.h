//
//  FeedBackBiz.h
//  NewLonking
//
//  Created by 李健 on 14-10-20.
//  Copyright (c) 2014年 王亮. All rights reserved.
//该模块儿用于反馈用户信息，不需要存储数据库

#define FEEDBACK_NOTIFICATION_POST_CUSTOMERINFO @"feedback notification post customer infomation"

#import "BaseBiz.h"
@class Customers;

@interface FeedBackBiz : BaseBiz

/**
 *	@brief  发送请求提交客户资料
 *
 *	@param 	times   最后一次更新学习资料的时间
 *
 *	@return	nil
 */
+ (void)startSendCustomerInfoToServiceWithWithCustomers:(Customers *)aCustomer;

@end
