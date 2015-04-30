//
//  ResourceService.h
//  NewLonking
//
//  Created by 李健 on 14-10-13.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseService.h"

@interface ResourceService : BaseService

/**
 *	@brief  获取资源列表 ，包括图片及其他格式资源等
 *
 *	@param 	aTimes 	最后更新时间
 *
 *	@return	nil
 */
+ (void)sendRequestGetResourceList:(long long)aTimes;

/**
 *	@brief	下载资源文件接口
 *
 *	@param 	resourceName 	资源ID号
 *
 *  @param  resourceType    资源文件类型
 *
 *	@return	nil
 */
+ (void)sendRequestDownloadResourceWithResourceName:(NSString *)resourceName andResourceType:(NSString *)resourceType;

/**
 *	@brief	开启队列下载图片
 *
 *	@param 	urlList 	图片队列
 *
 *	@return	nil
 */
//+ (void)sendRequestDownloadImageInQueueWithUrlList:(NSArray *)urlList;

@end
