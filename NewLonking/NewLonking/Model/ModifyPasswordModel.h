//
//  ModifyPasswordModel.h
//  NewLonking
//
//  Created by lijian on 14/11/16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseModel.h"

@interface ModifyPasswordModel : BaseModel

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *oldPassword;
@property (nonatomic, copy) NSString *password;
@end
