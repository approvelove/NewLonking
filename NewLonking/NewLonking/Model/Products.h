//
//  Products.h
//  NewLonking
//
//  Created by 李健 on 14-8-26.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseModel.h"
@class ResourceModel;
@class ProductTypeModel;

@interface Products : BaseModel

@property(nonatomic, strong) ProductTypeModel *typeModel; //产品类型
@property(nonatomic, copy) NSString *name;   //产品名
@property(nonatomic, strong) NSNumber *orderindex;
@property(nonatomic, strong) ResourceModel *imgModel;  //产品图样
@property (nonatomic, strong) ResourceModel *modelImageModel; //产品模型图
@property (nonatomic , strong) ResourceModel *productDataImageModel; //产品参数图
@property (nonatomic , strong) NSString *description; //产品描述

@end
