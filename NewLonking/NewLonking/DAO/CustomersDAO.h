//
//  CustomersDAO.h
//  NewLonking
//
//  Created by 李健 on 14-10-9.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Customers;
@class CustomersDB;

@interface CustomersDAO : NSObject

+ (BOOL)save:(Customers *)model;
+ (CustomersDB *)findById:(NSString *)customersId;
+ (BOOL)clearData;
+ (BOOL)deleteById:(NSString *)customersId;
+ (BOOL)update:(Customers *)model;
@end
