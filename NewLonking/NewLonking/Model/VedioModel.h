//
//  VedioModel.h
//  NewLonking
//
//  Created by lijian on 14/12/7.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseModel.h"
@class ResourceModel;
@class LearningMaterials;

@interface VedioModel : BaseModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) ResourceModel *resource;

////该接口不做数据库层的转换
- (LearningMaterials *)toLearningMaterials;
@end
