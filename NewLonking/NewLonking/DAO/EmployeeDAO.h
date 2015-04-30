//
//  EmployeeDAO.h
//  NewLonking
//
//  Created by 李健 on 14-10-9.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EmployeeModel;
@class EmployeeDB;

@interface EmployeeDAO : NSObject

+ (BOOL)save:(EmployeeModel *)model;
+ (EmployeeDB *)findById:(NSString *)employeeId;
+ (BOOL)clearData;
+ (BOOL)deleteById:(NSString *)employeeId;
+ (BOOL)update:(EmployeeModel *)model;
@end
