//
//  VedioBiz.h
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#define  NOTIFICATION_GET_VEDIOS @"notification get vedios"

#import "BaseBiz.h"

@interface VedioBiz : BaseBiz

/**
 *	@brief	保存视频学习资料
 *
 *	@param 	aArray 	从服务器端请求到的视频资料
 *
 *	@return	返回VedioModel
 */
+ (NSArray *)saveVedioDicDataWithArray:(NSArray *)aArray;

/**
 *	@brief  发送请求获取视频资料
 *
 *	@param 	times   最后一次获取首页轮播图的时间
 *
 *	@return	nil
 */
+ (void)startLoadVedioDataFromServiceWithWithTimes:(NSString *)times;

@end
