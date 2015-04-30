//
//  ProductTypeDAO.h
//  NewLonking
//
//  Created by 李健 on 14-10-16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//产品类型图片

#import <Foundation/Foundation.h>
@class ProductTypeModel;
@class ProductTypeDB;

@interface ProductTypeDAO : NSObject

+ (NSArray *)findAll;
+ (BOOL)save:(ProductTypeModel *)model;
+ (ProductTypeDB *)findById:(NSString *)typeId;
+ (BOOL)clearData;
+ (BOOL)deleteById:(NSString *)typeId;
+ (BOOL)update:(ProductTypeModel *)model;
+ (ProductTypeDB *)findByTypeName:(NSString *)typeName;
@end
