//
//  HotProductDB.h
//  NewLonking
//
//  Created by 李健 on 14-10-16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ResourceDB;
@class HotProductModel;

@interface HotProductDB : NSManagedObject

@property (nonatomic, retain) NSString * hotproductid;
@property (nonatomic, retain) ResourceDB *resource;
@property (nonatomic, retain) NSString * orderindex;

- (HotProductDB *)fromModel:(HotProductModel *)model;
- (HotProductModel *)toModel;
@end
