//
//  HotProductDB.m
//  NewLonking
//
//  Created by 李健 on 14-10-16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "HotProductDB.h"
#import "ResourceDB.h"
#import "HotProductModel.h"
#import "ResourceDAO.h"
#import "ResourceModel.h"

@implementation HotProductDB

@dynamic hotproductid;
@dynamic resource;
@dynamic orderindex;

- (HotProductDB *)fromModel:(HotProductModel *)model
{
    if (model == nil) {
        return nil;
    }
    self.hotproductid = model.modelId;
    self.orderindex = model.orderindex;
    ResourceDB *resDB = [ResourceDAO findById:model.resource.modelId];
    if (!resDB) {
        [ResourceDAO save:model.resource];
    }
    resDB = [ResourceDAO findById:model.resource.modelId];
    self.resource = resDB;
    return self;

}

- (HotProductModel *)toModel
{
    if (self) {
        HotProductModel *model = [[HotProductModel alloc] init];
        model.modelId = self.hotproductid;
        model.resource = [self.resource toModel];
        model.orderindex = self.orderindex;
        return model;
    }
    return nil;
}
@end
