//
//  ActivityBiz.h
//  NewLonking
//
//  Created by 李健 on 14-10-14.
//  Copyright (c) 2014年 王亮. All rights reserved.
//活动模块儿
#define ACTIVITY_NOTIFICATION_GET_ITEMS @"activity notification get items"
#define ACTIVITY_NOTIFICATION_GET_RESOURCE @"activity notification get resource"

#import "BaseBiz.h"

@interface ActivityBiz : BaseBiz

/**
 *	@brief	保存龙工活动部分的分类（分三类）
 *
 *	@param 	aArray 	从服务器端请求龙工活动的数据
 *
 *	@return	返回关于我们model
 */
+ (NSArray *)saveActivityItemsDataWithArray:(NSArray *)aArray;

/**
 *	@brief	为从网络加载下载龙工活动表做初始准备
 *
 *	@param 	times 	当前更新的最新时间
 *
 *	@return	nil
 */
+ (void)startLoadActivityItemsFromServiceWithTimes:(NSString *)times;

/**
 *	@brief	存储龙工活动的资源
 *
 *	@param 	aArray 	从服务器端下载的资源
 *
 *	@return	关于我们的完整model
 */
+ (NSArray *)saveActivityResourceDataWithArray:(NSArray *)aArray;

/**
 *	@brief	从服务器端下载龙工活动的相关资源
 *
 *	@param 	times 	最后下载时间
 *
 *	@return	nil
 */
+ (void)startLoadActivityResourceFromServiceWithTimes:(NSString *)times;
@end
