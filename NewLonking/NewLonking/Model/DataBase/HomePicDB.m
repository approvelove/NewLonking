//
//  HomePicDB.m
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "HomePicDB.h"
#import "ResourceDB.h"
#import "HomePicModel.h"
#import "ResourceDAO.h"
#import "ResourceModel.h"

@implementation HomePicDB

@dynamic homepicid;
@dynamic updateTime;
@dynamic valid;
@dynamic resource;

- (HomePicDB *)fromModel:(HomePicModel *)model
{
    if (model == nil) {
        return nil;
    }
    self.homepicid = model.modelId;
    self.updateTime = model.updateTime;
    self.valid = model.valid;
    ResourceDB * tempDB= [ResourceDAO findById:model.resource.modelId];
    if (!tempDB) {
        [ResourceDAO save:model.resource];
    }
    tempDB = [ResourceDAO findById:model.resource.modelId];
    self.resource = tempDB;
    return self;
}

- (HomePicModel *)toModel
{
    if (self) {
        HomePicModel *model = [[HomePicModel alloc] init];
        model.modelId = self.homepicid;
        model.updateTime = self.updateTime;
        model.valid = self.valid;
        model.resource = [self.resource toModel];
        return model;
    }
    return nil;
}
@end
