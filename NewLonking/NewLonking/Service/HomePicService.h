//
//  HomePicService.h
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseService.h"

@interface HomePicService : BaseService

/**
 *	@brief	获取首页轮播的图片
 *
 *	@param 	aTimes 	最后一次更新的时间
 */
+ (void)sendRequestGetHomePicWithTimes:(long long)aTimes;
@end
