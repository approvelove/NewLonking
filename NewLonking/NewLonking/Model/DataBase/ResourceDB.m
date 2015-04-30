//
//  ResourceDB.m
//  Pods
//
//  Created by 李健 on 14-9-17.
//
//

#import "ResourceDB.h"
#import "ResourceModel.h"

@implementation ResourceDB

@dynamic resourceId;
@dynamic name;
@dynamic type;


- (ResourceDB *)fromModel:(ResourceModel *)model
{
    if (model == nil) {
        return nil;
    }
    self.resourceId = model.modelId;
    self.name = model.name;
    self.type = model.type;
    return self;
}

- (ResourceModel *)toModel
{
    if (self) {
        ResourceModel *model = [[ResourceModel alloc] init];
        model.modelId = self.resourceId;
        model.name = self.name;
        model.type = self.type;
        return model;
    }
    return nil;
}
@end
