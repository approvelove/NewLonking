//
//  EmployeeModel.h
//  NewLonking
//
//  Created by 李健 on 14-8-26.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseModel.h"

@interface EmployeeModel : BaseModel
@property(nonatomic, copy) NSString *userName;  //工号
@property(nonatomic, copy) NSString *password;
@property(nonatomic, copy) NSString *realName;   //用户真实姓名
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *createTime;

@end
