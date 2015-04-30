//
//  LearningMaterialsService.h
//  NewLonking
//
//  Created by 李健 on 14-10-13.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseService.h"

@interface LearningMaterialsService : BaseService

/**
 *	@brief	获取学习资料
 *
 *	@param 	aTimes 	最后更新时间
 *
 *	@return	nil
 */
+ (void)sendRequestGetLearningMaterials:(long long)aTimes;

@end
