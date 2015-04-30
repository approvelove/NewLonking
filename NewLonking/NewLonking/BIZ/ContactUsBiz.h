//
//  ContactUsBiz.h
//  NewLonking
//
//  Created by 李健 on 14-10-14.
//  Copyright (c) 2014年 王亮. All rights reserved.
//联系我们 模块儿

#define CONTACTUS_NOTIFICATION_GET_CONTACTINFO @"contact us notification get contact info"

#import "BaseBiz.h"

@interface ContactUsBiz : BaseBiz

/**
 *	@brief   保存联系我们的相关信息
 *
 *	@param 	aArray 	从服务器端请求到的员工列表
 *
 *	@return	返回该员工表的model
 */
+ (NSArray *)saveContactUsDataWithArray:(NSArray *)aArray;

/**
 *	@brief	为从网络下载公司信息
 *
 *	@param 	times 	当前更新的最新时间
 *
 *	@return	nil
 */
+ (void)startLoadContactUsInfoFromServiceWithTimes:(NSString *)times;
@end
