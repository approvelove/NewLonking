//
//  ContactUsService.h
//  NewLonking
//
//  Created by 李健 on 14-10-13.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseService.h"

@interface ContactUsService : BaseService

/**
 *	@brief	获取联系我们相关的信息
 *
 *	@param 	aTimes 	最后更新时间
 *
 *	@return	nil
 */
+ (void)sendRequestGetInformationOfUs:(long long)aTimes;

@end
