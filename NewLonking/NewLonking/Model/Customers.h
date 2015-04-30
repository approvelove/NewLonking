//
//  Customers.h
//  NewLonking
//
//  Created by 李健 on 14-8-26.
//  Copyright (c) 2014年 王亮. All rights reserved.
//客户model ,该model是直接发送到服务器端，供服务器端存储的。不用存储到本地

#import "BaseModel.h"

@interface Customers : BaseModel
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *country;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *tel;
@property(nonatomic, copy) NSString *interestedProductName;

@end
