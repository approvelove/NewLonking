//
//  ProductTypeModel.h
//  NewLonking
//
//  Created by 李健 on 14-10-16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseModel.h"
@class ResourceModel;

@interface ProductTypeModel : BaseModel
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, strong) ResourceModel *resource;
@end
