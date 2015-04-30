//
//  ActivitiesDAO.h
//  NewLonking
//
//  Created by 李健 on 14-10-9.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ActivitiesModel;
@class ActivitiesDB;

@interface ActivitiesDAO : NSObject

+ (BOOL)save:(ActivitiesModel *)model;
+ (ActivitiesDB *)findById:(NSString *)activitiesId;
+ (BOOL)clearData;
+ (BOOL)deleteById:(NSString *)activitiesId;
+ (BOOL)update:(ActivitiesModel *)model;
+ (NSArray *)findAll;
@end
