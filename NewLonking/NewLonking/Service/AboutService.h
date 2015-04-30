//
//  AboutService.h
//  NewLonking
//
//  Created by 李健 on 14-10-13.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseService.h"

@interface AboutService : BaseService

/**
 *	@brief	获取关于龙工的分类部分
 *
 *	@param 	aTimes 	上次获取的最新时间
 *
 *	@return	nil
 */
+ (void)sendRequestGetAboutLonkingItems:(long long)aTimes;

/**
 *	@brief	获取关于我们的资源部分，图片地址等
 *
 *	@param 	aTimes 	上次更新的最新时间
 *
 *	@return	nil
 */
+ (void)sendRequestGetAboutLonkingResource:(long long)aTimes;

@end
