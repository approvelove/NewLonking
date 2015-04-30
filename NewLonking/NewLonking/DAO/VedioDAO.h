//
//  VedioDAO.h
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VedioModel;
@class VedioDB;

@interface VedioDAO : NSObject

+ (NSArray *)findAll;
+ (BOOL)save:(VedioModel *)model;
+ (VedioDB *)findById:(NSString *)aboutId;
+ (BOOL)clearData;
+ (BOOL)deleteById:(NSString *)aboutId;
+ (BOOL)update:(VedioModel *)model;
@end
