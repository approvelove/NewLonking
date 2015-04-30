//
//  EmployeeBiz.m
//  NewLonking
//
//  Created by 李健 on 14-10-14.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "EmployeeBiz.h"
#import "EmployeeDAO.h"
#import "EmployeeModel.h"
#import "LoginService.h"
#import "EmployeeModel.h"

@implementation EmployeeBiz

+ (NSArray *)saveloginDataWithDict:(NSDictionary *)aDict
{
    NSAssert(aDict != nil, @"method saveloginDataWithDict has failed!");
    NSMutableArray *tempAry = [@[] mutableCopy];
    EmployeeModel *emModel = [EmployeeModel loadFromService:aDict];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:aDict forKey:@"userInfo"];  //将该用户信息存储到userdefaults里面
    [tempAry addObject:emModel];
    return tempAry;
}

+ (NSArray *)saveEmployeeDataWithArray:(NSArray *)aArray
{
    NSAssert(aArray != nil, @"method saveEmployeeDataWithArray has failed!");
    NSMutableArray *tempAry = [@[] mutableCopy];
    [aArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        EmployeeModel *emModel = [EmployeeModel loadFromService:obj];
        if (![EmployeeDAO findById:emModel.modelId]) {
            if ([emModel.valid isEqualToString:@"0"]) {
                [EmployeeDAO save:emModel];
            }
        }
        else
        {
            if ([emModel.valid isEqualToString:@"0"]) {
                [EmployeeDAO update:emModel];
            }
            else
            {
                [EmployeeDAO deleteById:emModel.modelId];
            }
        }
        if ([emModel.valid isEqualToString:@"0"]) {
            [tempAry addObject:emModel];
        }
    }];
    return tempAry;
}

+ (void)startLoadEmployeeListFromServiceWithTimes:(NSString *)times
{
    long long recordTimes = [times longLongValue];
    [LoginService sendRequestGetEmployeeListWithLatestUpdateTime:recordTimes];
}

+ (void)startModifyPasswordWithModel:(ModifyPasswordModel *)aModel
{
    [LoginService modifyPasswordWithModel:aModel];
}
///////////////////////////////////////////////////////////
+ (void)startLoginWithEmployee:(EmployeeModel *)model
{
    [LoginService employeeLoginWithAgentID:model.userName andPwd:model.password];
}

+ (void)clearLoginInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@{} forKey:@"userInfo"];
    [defaults synchronize];
}

+ (BOOL)verifyHasLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *tempDict = [defaults objectForKey:@"userInfo"];
    if (tempDict == nil || tempDict.count == 0) {
        return NO;
    }
    else
    {
        return YES;
    }
}
@end
