//
//  ResourceDAO.h
//  NewLonking
//
//  Created by 李健 on 14-9-17.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ResourceDB;
@class ResourceModel;

@interface ResourceDAO : NSObject

+ (BOOL)save:(ResourceModel *)model;

+ (ResourceDB *)findById:(NSString *)resourceId;
+ (BOOL)clearData;
+ (BOOL)deleteById:(NSString *)resourcetId;
+ (BOOL)update:(ResourceModel *)model;
@end
