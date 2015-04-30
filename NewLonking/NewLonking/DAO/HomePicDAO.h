//
//  HomePicDAO.h
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomePicModel;
@class HomePicDB;
@interface HomePicDAO : NSObject

+ (NSArray *)findAll;
+ (BOOL)save:(HomePicModel *)model;
+ (HomePicDB *)findById:(NSString *)aboutId;
+ (BOOL)clearData;
+ (BOOL)deleteById:(NSString *)aboutId;
+ (BOOL)update:(HomePicModel *)model;
@end
