//
//  LearningMaterialsDAO.h
//  NewLonking
//
//  Created by 李健 on 14-10-9.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LearningMaterials;
@class LearningMaterialsDB;

@interface LearningMaterialsDAO : NSObject

+ (BOOL)save:(LearningMaterials *)model;
+ (LearningMaterialsDB *)findById:(NSString *)learnMaterialsId;
+ (BOOL)clearData;
+ (BOOL)deleteById:(NSString *)learnMaterialsId;
+ (BOOL)update:(LearningMaterials *)model;
+ (NSArray *)findAll;
@end
