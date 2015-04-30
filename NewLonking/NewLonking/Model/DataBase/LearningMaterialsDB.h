//
//  LearningMaterialsDB.h
//  Pods
//
//  Created by 李健 on 14-9-17.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ResourceDB;
@class LearningMaterials;

@interface LearningMaterialsDB : NSManagedObject

@property (nonatomic, retain) NSString * learnMaterialsId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * uploadDate;
@property (nonatomic, retain) ResourceDB *materials;
@property (nonatomic, retain) NSString * uploader;

- (LearningMaterialsDB *)fromModel:(LearningMaterials *)model;

- (LearningMaterials *)toModel;
@end
