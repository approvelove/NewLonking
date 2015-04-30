//
//  AboutDB.m
//  NewLonking
//
//  Created by 李健 on 14-10-9.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "AboutDB.h"
#import "ResourceDB.h"
#import "AboutModel.h"
#import "ResourceModel.h"
#import "ResourceDAO.h"

@implementation AboutDB

@dynamic aboutId;
@dynamic content;
@dynamic type;
@dynamic imgAry;

- (AboutDB *)fromModel:(AboutModel *)model
{
    NSAssert(model != nil, @"model count be nil");
    self.aboutId = model.modelId;
    self.content = model.content;
    self.type = model.type;
/*
 *********************************************** ResourceModel to ResourceDB*****************************************
 *********************************************** NSArray to NSSet ***************************************************
 */
    if (model.imgAry.count>0) {
        NSMutableSet *tempSet = [NSMutableSet set];
        [model.imgAry enumerateObjectsUsingBlock:^(ResourceModel *obj, NSUInteger idx, BOOL *stop) {
            ResourceDB * tempDB= [ResourceDAO findById:obj.modelId];
            if (!tempDB) {
                [ResourceDAO save:obj];
            }
            tempDB = [ResourceDAO findById:obj.modelId];
            [tempSet addObject:tempDB];
        }];
        self.imgAry = tempSet;
    }
    return self;
}

- (AboutModel *)toModel
{
    NSAssert(self, @"this object has dealloc");
    AboutModel *model = [[AboutModel alloc] init];
    model.modelId = self.aboutId;
    model.content = self.content;
    model.type = self.type;
/*
 *********************************************** ResourceDB to ResourceModel*****************************************
 *********************************************** NSSet to NSArray ***************************************************
*/
    if (self.imgAry.count>0) {
        NSMutableArray *tempAry = [@[] mutableCopy];
        [self.imgAry enumerateObjectsUsingBlock:^(ResourceDB *obj, BOOL *stop) {
            ResourceModel *resModel = [obj toModel];
            [tempAry addObject:resModel];
        }];
        model.imgAry = tempAry;
    }
    return model;
}
@end
