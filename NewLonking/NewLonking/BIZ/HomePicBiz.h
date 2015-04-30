//
//  HomePicBiz.h
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//


#define NOTIFICATION_GET_HOMEPIC @"notification get homepic"

#import "BaseBiz.h"

@interface HomePicBiz : BaseBiz

/**
 *	@brief	保存首页轮播图
 *
 *	@param 	aArray 	从服务器端请求到的首页产品图片的数据
 *
 *	@return	返回HomePicModel
 */
+ (NSArray *)saveHomePicDataWithArray:(NSArray *)aArray;

/**
 *	@brief  发送请求获取首页轮播图
 *
 *	@param 	times   最后一次获取首页轮播图的时间
 *
 *	@return	nil
 */
+ (void)startLoadHomePicDataFromServiceWithWithTimes:(NSString *)times;
@end
