//
//  EmployeeDB.h
//  Pods
//
//  Created by 李健 on 14-9-17.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EmployeeModel;
@interface EmployeeDB : NSManagedObject

@property (nonatomic, retain) NSString * employeeId;
@property (nonatomic, retain) NSString * realName;   //真实姓名
@property (nonatomic, retain) NSString * userName;  //工号
@property (nonatomic, retain) NSString * password;

- (EmployeeDB *)fromModel:(EmployeeModel *)model;
- (EmployeeModel *)toModel;
@end