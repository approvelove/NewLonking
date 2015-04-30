//
//  ActivityService.h
//  NewLonking
//
//  Created by 李健 on 14-10-13.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseService.h"

@interface ActivityService : BaseService

/**
 *	@brief	获取活动部分的项目
 *
 *	@param 	aTimes   最后更新时间
 *
 *	@return	nil
 */
+ (void)sendRequestGetActivityItems:(long long)aTimes;

/**
 *	@brief	获取活动的资源部分，图片地址等
 *
 *	@param 	aTimes  最后更新时间
 *
 *	@return	nil
 */
+ (void)sendRequestGetActivityResources:(long long)aTimes;

@end
