//
//  ActivitiesDB.m
//  Pods
//
//  Created by 李健 on 14-9-17.
//
//

#import "ActivitiesDB.h"
#import "ResourceDB.h"
#import "ActivitiesModel.h"
#import "ResourceDAO.h"
#import "ResourceModel.h"

@implementation ActivitiesDB

@dynamic activitiesId;
@dynamic type;
@dynamic imgAry;

- (ActivitiesDB *)fromModel:(ActivitiesModel *)model
{
    if (model == nil) {
        return nil;
    }
    self.activitiesId = model.modelId;
    self.type = model.type;
/*
  ******************************************imgAry************************************************
 */
    NSMutableSet *tempSet = [NSMutableSet set];
    if (model.imgAry.count>0) {
        for (int i = 0 ; i< model.imgAry.count; i++) {
            ResourceModel *resModel = model.imgAry[i];
            ResourceDB *resDB = [ResourceDAO findById:resModel.modelId];
            if (!resDB) {
                [ResourceDAO save:resModel];
            }
            resDB = [ResourceDAO findById:resModel.modelId];
            [tempSet addObject:resDB];
        }
        self.imgAry = tempSet;
    }
    return self;
}

- (ActivitiesModel *)toModel
{
    if (self) {
        ActivitiesModel *model = [[ActivitiesModel alloc] init];
        model.modelId = self.activitiesId;
        model.type = self.type;
/*
 *************************************************** ResourceDB to ResourceModel*************************************
 */
        if(self.imgAry.count>0) {
            NSMutableArray *tempAry = [@[] mutableCopy];
            [self.imgAry enumerateObjectsUsingBlock:^(ResourceDB *obj, BOOL *stop) {
                ResourceModel *resModel = [obj toModel];
                [tempAry addObject:resModel];
            }];
            model.imgAry = tempAry;
        }
        return model;
    }
    return nil;
}
@end
