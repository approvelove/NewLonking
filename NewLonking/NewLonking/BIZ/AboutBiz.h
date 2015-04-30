//
//  AboutBiz.h
//  NewLonking
//
//  Created by 李健 on 14-10-14.
//  Copyright (c) 2014年 王亮. All rights reserved.
//关于龙工模块儿

#define ABOUT_NOTIFICATION_GET_ABOUTLONKING_ITEMS @"about notification get aboutlonking items"
#define ABOUT_NOTIFICATION_GET_ABOUTLONKING_RESOURCE @"about notification get aboutlonking resource"

#import "BaseBiz.h"

@interface AboutBiz : BaseBiz


/**
 *	@brief	保存关于龙工部分的分类（分三类）
 *
 *	@param 	aArray 	从服务器端请求关于龙工的数据
 *
 *	@return	返回关于我们model
 */
+ (NSArray *)saveAboutItemsDataWithArray:(NSArray *)aArray;

/**
 *	@brief	为从网络加载下载关于龙工表做初始准备
 *
 *	@param 	times 	当前更新的最新时间
 *
 *	@return	nil
 */
+ (void)startLoadAboutItemsFromServiceWithTimes:(NSString *)times;

/**
 *	@brief	存储关于龙工的资源
 *
 *	@param 	aArray 	从服务器端下载的资源
 *
 *	@return	关于我们的完整model
 */
+ (NSArray *)saveAboutResourceDataWithArray:(NSArray *)aArray;

/**
 *	@brief	从服务器端下载关于龙工的相关资源
 *
 *	@param 	times 	最后下载时间
 *
 *	@return	nil
 */
+ (void)startLoadAboutResourceFromServiceWithTimes:(NSString *)times;

@end
