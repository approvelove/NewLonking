//
//  EmployeeDB.m
//  Pods
//
//  Created by 李健 on 14-9-17.
//
//

#import "EmployeeDB.h"
#import "EmployeeModel.h"

@implementation EmployeeDB

@dynamic employeeId;
@dynamic realName;
@dynamic userName;
@dynamic password;

- (EmployeeDB *)fromModel:(EmployeeModel *)model
{
    if (model == nil) {
        return nil;
    }
    self.employeeId = model.modelId;
    self.realName = model.realName;
    self.userName = model.userName;
    self.password = model.password;
    return self;
}

- (EmployeeModel *)toModel
{
    if (self) {
        EmployeeModel *model = [[EmployeeModel alloc] init];
        model.modelId = self.employeeId;
        model.userName = self.userName;
        model.realName = self.realName;
        model.password = self.password;
        return model;
    }
    return nil;
}
@end
