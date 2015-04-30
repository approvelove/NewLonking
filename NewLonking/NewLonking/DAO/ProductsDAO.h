//
//  ProductsDAO.h
//  NewLonking
//
//  Created by 李健 on 14-10-9.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Products;
@class ProductsDB;

@interface ProductsDAO : NSObject

+ (BOOL)save:(Products *)model;
+ (ProductsDB *)findById:(NSString *)productsId;
+ (BOOL)clearData;
+ (BOOL)deleteById:(NSString *)productsId;
+ (BOOL)update:(Products *)model;
+ (NSArray *)findAll;
@end
