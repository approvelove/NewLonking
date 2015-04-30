//
//  VedioDB.m
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "VedioDB.h"
#import "ResourceDB.h"
#import "VedioModel.h"
#import "ResourceDAO.h"
#import "ResourceModel.h"

@implementation VedioDB

@dynamic vedioid;
@dynamic title;
@dynamic updateTime;
@dynamic updator;
@dynamic resource;
@dynamic valid;

- (VedioDB *)fromModel:(VedioModel *)model
{
    if (model == nil) {
        return nil;
    }
    self.vedioid = model.modelId;
    self.updateTime = model.updateTime;
    self.valid = model.valid;
    self.title = model.title;
    self.updator = model.updator;
    ResourceDB * tempDB= [ResourceDAO findById:model.resource.modelId];
    if (!tempDB) {
        [ResourceDAO save:model.resource];
    }
    tempDB = [ResourceDAO findById:model.resource.modelId];
    self.resource = tempDB;
    return self;
}

- (VedioModel *)toModel
{
    if (self) {
        VedioModel *model = [[VedioModel alloc] init];
        model.modelId = self.vedioid;
        model.updateTime = self.updateTime;
        model.valid = self.valid;
        model.title = self.title;
        model.updator = self.updator;
        model.resource = [self.resource toModel];
        return model;
    }
    return nil;
}

@end
