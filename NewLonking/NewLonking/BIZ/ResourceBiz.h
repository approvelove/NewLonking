//
//  ResourceBiz.h
//  NewLonking
//
//  Created by 李健 on 14-10-14.
//  Copyright (c) 2014年 王亮. All rights reserved.
//资源列表（用于请求所有的资源地址）


#define RESOURCE_NOTIFICATION_GET_RESOURCELIST @"resource notification to get resource list"
#define RESOURCE_NOTIFICATION_POST_TOGET_RESOURCE @"resource notification post to get resource data"

#import "BaseBiz.h"
@class ResourceModel;

@interface ResourceBiz : BaseBiz

/**
 *	@brief	发送请求下载图片数据
 *
 *	@param 	ResourceModel 	资源文件
 *
 *	@return	nil
 */
+ (void)startLoadImageDataFromServiceWithResourceModel:(ResourceModel *)resourceModel;

/**
 *	@brief	保存图片到指定路径
 *
 *	@param 	aImage 	图片
 *
 *	@param 	fileName 	图片名
 *
 *	@return	图片数组
 */
+ (NSArray *)saveResourceImageDataWithImage:(UIImage *)aImage andFileName:(NSString *)fileName;

/**
 *	@brief   发送请求获取资源列表
 *
 *	@param 	times 	最后一次下载的时间
 *
 *	@return	nil
 */
+ (void)startLoadResouceListDataFromServiceWithTimes:(NSString *)times;

/**
 *	@brief	保存资源列表到数据库
 *
 *	@param 	aArray 	从服务器端请求的资源列表数据
 *
 *	@return	返回ResourceModel 列表
 */
+ (NSArray *)saveResourceListDataWithArray:(NSArray *)aArray;
@end
