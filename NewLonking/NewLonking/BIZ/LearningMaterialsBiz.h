//
//  LearningMaterialsBiz.h
//  NewLonking
//
//  Created by 李健 on 14-10-20.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#define LEARNINGMATERIALS_NOTIFICATION_GET_LEARNINGMATERIALS @"learning materials notification get learning materials"

#import "BaseBiz.h"

@interface LearningMaterialsBiz : BaseBiz

/**
 *	@brief	保存学习资料到数据库
 *
 *	@param 	aArray 	从服务器端请求学习资料
 *
 *	@return	返回LearningMaterials Model
 */
+ (NSArray *)saveLearningMaterialsDataWithArray:(NSArray *)aArray;

/**
 *	@brief  发送请求获取学习资料
 *
 *	@param 	times   最后一次更新学习资料的时间
 *
 *	@return	nil
 */
+ (void)startLoadLearningMaterialsDataFromServiceWithWithTimes:(NSString *)times;
@end
