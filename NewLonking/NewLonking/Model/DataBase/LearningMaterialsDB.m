//
//  LearningMaterialsDB.m
//  Pods
//
//  Created by 李健 on 14-9-17.
//
//

#import "LearningMaterialsDB.h"
#import "ResourceDB.h"
#import "LearningMaterials.h"
#import "ResourceDAO.h"
#import "ResourceModel.h"

@implementation LearningMaterialsDB

@dynamic learnMaterialsId;
@dynamic name;
@dynamic uploadDate;
@dynamic materials;
@dynamic uploader;

- (LearningMaterialsDB *)fromModel:(LearningMaterials *)model
{
    if (model == nil) {
        return nil;
    }
    self.learnMaterialsId = model.modelId;
    self.name = model.name;
    self.uploadDate = model.uploadDateStr;
    self.uploader = model.updator;
    ResourceDB * tempDB= [ResourceDAO findById:model.resource.modelId];
    if (!tempDB) {
        [ResourceDAO save:model.resource];
    }
    tempDB= [ResourceDAO findById:model.resource.modelId];
    self.materials = tempDB;
    return self;
}

- (LearningMaterials *)toModel
{
    if (self) {
        LearningMaterials *model = [[LearningMaterials alloc] init];
        model.modelId = self.learnMaterialsId;
        model.name = self.name;
        model.subName = self.name;
        model.uploadDateStr = self.uploadDate;
        model.resource = [self.materials toModel];
        model.materialsUrl = self.materials.name;
        model.fileType = self.materials.type;
        model.updator = self.uploader;
        return model;
    }
    return nil;
}
@end
