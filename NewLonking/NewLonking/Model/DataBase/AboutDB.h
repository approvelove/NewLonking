//
//  AboutDB.h
//  NewLonking
//
//  Created by 李健 on 14-10-9.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ResourceDB;
@class AboutModel;

@interface AboutDB : NSManagedObject

@property (nonatomic, retain) NSString * aboutId;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *imgAry;

- (AboutDB *)fromModel:(AboutModel *)model;
- (AboutModel *)toModel;
@end
