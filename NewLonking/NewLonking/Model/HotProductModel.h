//
//  HotProductModel.h
//  NewLonking
//
//  Created by 李健 on 14-10-16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseModel.h"
@class ResourceModel;

@interface HotProductModel : BaseModel

@property (nonatomic, strong) ResourceModel *resource;
@property (nonatomic, copy) NSString *orderindex;

@end
