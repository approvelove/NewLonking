//
//  ProductTypeDB.h
//  NewLonking
//
//  Created by 李健 on 14-10-16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class ProductTypeModel;
@class ResourceDB;

@interface ProductTypeDB : NSManagedObject

@property (nonatomic, retain) NSString * typeId;
@property (nonatomic, retain) NSString * typeName;
@property (nonatomic, retain) NSString * valid;
@property (nonatomic, retain) ResourceDB *resource;

- (ProductTypeDB *)fromModel:(ProductTypeModel *)model;
- (ProductTypeModel *)toModel;
@end
