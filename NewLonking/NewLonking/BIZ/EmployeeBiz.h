//
//  EmployeeBiz.h
//  NewLonking
//
//  Created by 李健 on 14-10-14.
//  Copyright (c) 2014年 王亮. All rights reserved.
//员工列表模块儿（包含登录模块儿）

#define EMPLOYEE_NOTIFICATION_GET_LIST @"employee notification get employee list"
#define EMPLOYEE_NOTIFICATION_POST_TO_LOGIN @"employee notification post to login"
#define EMPLOYEE_NOTIFICATION_POST_TO_MODIFY_PWD @"employee notification post to modify pwd"

#import "BaseBiz.h"
@class EmployeeModel;
@class ModifyPasswordModel;

@interface EmployeeBiz : BaseBiz

/**
 *	@brief	保存下载好的员工表。如果员工表中存在某员工信息则不存储否则存储到相应数据库
 *
 *	@param 	aArray 	从服务器端请求到的员工列表
 *
 *	@return	返回该员工表的model
 */
+ (NSArray *)saveEmployeeDataWithArray:(NSArray *)aArray;

/**
 *	@brief	保存员工登录信息到userDefault
 *
 *	@param 	aDict 	从服务器端请求员工登录信息
 *
 *	@return	返回该员工表的model
 */
+ (NSArray *)saveloginDataWithDict:(NSDictionary *)aDict;

/**
 *	@brief	为从网络加载下载员工表做初始准备
 *
 *	@param 	times 	当前更新的最新时间
 *
 *	@return	nil
 */
+ (void)startLoadEmployeeListFromServiceWithTimes:(NSString *)times;

/**
 *	@brief	员工登录接口
 *
 *	@param 	model 	员工
 *
 *	@return	nil
 */
+ (void)startLoginWithEmployee:(EmployeeModel *)model;

/**
 *	@brief	修改密码
 *
 *	@param 	aModel 	修改密码model
 */
+ (void)startModifyPasswordWithModel:(ModifyPasswordModel *)aModel;


/**
 *	@brief	验证员工是否已经登录(直接从userdefaults里面查数据，如果有数据则说明已经登录成功)
 *
 *	@return	如果已经登录返回YES
 */
+ (BOOL)verifyHasLogin;

/**
 *	@brief	清空用户信息
 *
 *	@return	nil
 */
+ (void)clearLoginInfo;
@end
