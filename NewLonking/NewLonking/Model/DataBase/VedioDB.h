//
//  VedioDB.h
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ResourceDB;
@class VedioModel;

@interface VedioDB : NSManagedObject

@property (nonatomic, retain) NSString * vedioid;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * updateTime;
@property (nonatomic, retain) NSString * updator;
@property (nonatomic, retain) NSString *valid;
@property (nonatomic, retain) ResourceDB *resource;

- (VedioDB *)fromModel:(VedioModel *)model;

- (VedioModel *)toModel;
@end
