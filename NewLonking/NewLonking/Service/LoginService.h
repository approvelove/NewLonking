//
//  LoginService.h
//  NewLonking
//
//  Created by 李健 on 14-8-29.
//  Copyright (c) 2014年 王亮. All rights reserved.
//


#import "BaseService.h"
@class ModifyPasswordModel;

@interface LoginService : BaseService

/**
 *	@brief	用户登录信息验证
 *
 *	@param 	agentID    用户名
 *	@param 	pwd 	密码
 *
 *	@return	nil
 */
+ (void)employeeLoginWithAgentID:(NSString *)agentID andPwd:(NSString *)pwd;

/**
 *	@brief	同步员工信息列表
 *
 *	@param 	times 	上次同步的最新时间
 *
 *	@return	nil
 */
+ (void)sendRequestGetEmployeeListWithLatestUpdateTime:(long long)times;

+ (void)modifyPasswordWithModel:(ModifyPasswordModel *)model;
@end
