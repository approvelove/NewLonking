//
//  VedioService.h
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseService.h"

@interface VedioService : BaseService

/**
 *	@brief	获取视频
 *
 *	@param 	aTimes 	最后一次更新的时间
 */
+ (void)sendRequestGetVediosWithTimes:(long long)aTimes;
@end
