//
//  HomePicDB.h
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ResourceDB;
@class HomePicModel;

@interface HomePicDB : NSManagedObject

@property (nonatomic, retain) NSString * homepicid;
@property (nonatomic, retain) NSString * updateTime;
@property (nonatomic, retain) NSString * valid;
@property (nonatomic, retain) ResourceDB *resource;


- (HomePicDB *)fromModel:(HomePicModel *)model;

- (HomePicModel *)toModel;
@end
