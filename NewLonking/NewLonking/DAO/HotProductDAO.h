//
//  HotProductDAO.h
//  NewLonking
//
//  Created by 李健 on 14-10-16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//(产品首页的图片)

#import <Foundation/Foundation.h>
@class HotProductModel;
@class HotProductDB;

@interface HotProductDAO : NSObject

+ (NSArray *)findAll;
+ (BOOL)save:(HotProductModel *)model;
+ (HotProductDB *)findById:(NSString *)hotproductid;
+ (BOOL)clearData;
+ (BOOL)deleteById:(NSString *)hotproductid;
+ (BOOL)update:(HotProductModel *)model;
@end
