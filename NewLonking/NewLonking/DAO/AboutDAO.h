//
//  AboutDAO.h
//  NewLonking
//
//  Created by 李健 on 14-10-9.
//  Copyright (c) 2014年 王亮. All rights reserved.
//（关于图片）

#import <Foundation/Foundation.h>
@class AboutModel;
@class AboutDB;

@interface AboutDAO : NSObject

+ (NSArray *)findAll;
+ (BOOL)save:(AboutModel *)model;
+ (AboutDB *)findById:(NSString *)aboutId;
+ (BOOL)clearData;
+ (BOOL)deleteById:(NSString *)aboutId;
+ (BOOL)update:(AboutModel *)model;
@end
