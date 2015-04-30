//
//  ProductService.h
//  NewLonking
//
//  Created by 李健 on 14-10-16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseService.h"

@interface ProductService : BaseService

/**
 *	@brief	发送请求获取产品类型
 *
 *	@param 	aTimes 	最后一次更新的时间
 *
 *	@return	nil
 */
+ (void)sendRequestGetProductType:(long long)aTimes;

/**
 *	@brief	发送网络请求获取产品详细信息
 *
 *	@param 	aTimes   最后一次更新时间
 *
 *	@return	nil
 */
+ (void)sendRequestGetProduct:(long long)aTimes;


/**
 *	@brief	发送网络请求获取首页产品
 *
 *	@param 	aTimes 	最后一次更新时间
 *
 *	@return	nil
 */
+ (void)sendRequestGetHotProduct:(long long)aTimes;

@end
