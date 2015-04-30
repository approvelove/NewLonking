//
//  ProductTypeDB.m
//  NewLonking
//
//  Created by 李健 on 14-10-16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ProductTypeDB.h"
#import "ProductTypeModel.h"
#import "ResourceDB.h"
#import "ResourceDAO.h"
#import "ResourceModel.h"

@implementation ProductTypeDB

@dynamic typeId;
@dynamic typeName;
@dynamic valid;
@dynamic resource;

- (ProductTypeDB *)fromModel:(ProductTypeModel *)model
{
    if (model == nil) {
        return nil;
    }
    self.typeId = model.modelId;
    self.typeName = model.typeName;
    self.valid = model.valid;
    ResourceDB * tempDB= [ResourceDAO findById:model.resource.modelId];
    if (!tempDB) {
        [ResourceDAO save:model.resource];
    }
    tempDB= [ResourceDAO findById:model.resource.modelId];
    self.resource = tempDB;
    return self;
}

- (ProductTypeModel *)toModel
{
    if (self) {
        ProductTypeModel *model = [[ProductTypeModel alloc] init];
        model.modelId = self.typeId;
        model.typeName = self.typeName;
        model.valid = self.valid;
        if (self.resource) {
            model.resource = [self.resource toModel];
        }
        return model;
    }
    return nil;
}
@end
