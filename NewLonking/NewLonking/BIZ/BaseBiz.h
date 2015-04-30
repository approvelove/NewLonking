//
//  BaseBiz.h
//  NewLonking
//
//  Created by 李健 on 14-8-12.
//  Copyright (c) 2014年 王亮. All rights reserved.
//业务逻辑层

#import <Foundation/Foundation.h>

@interface BaseBiz : NSObject

/**
 *	@brief	加载同步数据状态表。 该表记录了每一个数据的最后更新时间
 *
 *	@return	同步状态表
 */
+ (NSDictionary *)loadSynchronizePlist;

/**
 *	@brief	向同步数据状态表中添加最新更新时间
 *
 *	@param 	infoDict 	时间表
 *
 *	@return	nil
 */
+ (void)writeSynchronizeStatusToPlist:(NSDictionary *)infoDict;

/**
 *	@brief	加载数据
 *
 *	@param 	name   文件名
 *
 *	@return	返回存储的的数据
 */
+ (NSDictionary *)loadPlistWithPlistName:(NSString *)name;
@end
