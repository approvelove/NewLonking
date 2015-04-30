//
//  LoginService.m
//  NewLonking
//
//  Created by 李健 on 14-8-29.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "LoginService.h"
#import "EmployeeBiz.h"
#import "EmployeeModel.h"
#import "ModifyPasswordModel.h"
#import "CommonHelper.h"

@implementation LoginService

+ (void)employeeLoginWithAgentID:(NSString *)agentID andPwd:(NSString *)pwd
{
    NSString *urlString = [NSString stringWithFormat:@"%@employee/login",HOST];
    NSDictionary *paramDict = @{@"username":agentID,@"pwd":[CommonHelper md5:pwd]};
    [[AFHTTPRequestOperationManager manager] POST:urlString parameters:paramDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *employeeModelArray = [NSArray array];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            employeeModelArray = nil;
            employeeModelArray = [EmployeeBiz saveloginDataWithDict:responseObject[@"resultData"]];
        }
        [CommonHelper postNotification:EMPLOYEE_NOTIFICATION_POST_TO_LOGIN userInfo:@{@"resultData":employeeModelArray,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *employeeModelArray = [NSArray array];
        [CommonHelper postNotification:EMPLOYEE_NOTIFICATION_POST_TO_LOGIN userInfo:@{@"resultData":employeeModelArray}];
    }];
}

+ (void)modifyPasswordWithModel:(ModifyPasswordModel *)model
{
    NSString *urlString = [NSString stringWithFormat:@"%@employee/update",HOST];
    NSDictionary *paramDict = @{@"empid":model.userId,@"oldpwd":[CommonHelper md5:model.oldPassword],@"pwd":[CommonHelper md5:model.password]};
    [[AFHTTPRequestOperationManager manager] POST:urlString parameters:paramDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *employeeModelArray = [NSArray array];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            employeeModelArray = nil;
            employeeModelArray = [EmployeeBiz saveloginDataWithDict:responseObject[@"resultData"]];
        }
        [CommonHelper postNotification:EMPLOYEE_NOTIFICATION_POST_TO_MODIFY_PWD userInfo:@{@"resultData":employeeModelArray,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *employeeModelArray = [NSArray array];
        [CommonHelper postNotification:EMPLOYEE_NOTIFICATION_POST_TO_MODIFY_PWD userInfo:@{@"resultData":employeeModelArray}];
    }];
}

+ (void)sendRequestGetEmployeeListWithLatestUpdateTime:(long long)times
{
    NSString *urlString = [NSString stringWithFormat:@"%@employee/%lld",HOST,times];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSArray *employeeModelArray = [NSArray array];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            employeeModelArray = nil;
            employeeModelArray = [EmployeeBiz saveEmployeeDataWithArray:responseObject[@"resultData"]];
            if (employeeModelArray.count>0) {
                EmployeeModel *lastModel = [employeeModelArray lastObject];
                NSMutableDictionary *synchronizeTable = [[EmployeeBiz loadSynchronizePlist] mutableCopy];
                [synchronizeTable setValue:lastModel.updateTime forKey:@"employee"];
                [EmployeeBiz writeSynchronizeStatusToPlist:synchronizeTable];
            }
        }
        [CommonHelper postNotification:EMPLOYEE_NOTIFICATION_GET_LIST userInfo:@{@"resultData":employeeModelArray,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *employeeModelArray = [NSArray array];
        [CommonHelper postNotification:EMPLOYEE_NOTIFICATION_GET_LIST userInfo:@{@"resultData":employeeModelArray}];
    }];
}

@end
