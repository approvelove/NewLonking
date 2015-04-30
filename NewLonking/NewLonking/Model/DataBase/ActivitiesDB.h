//
//  ActivitiesDB.h
//  Pods
//
//  Created by 李健 on 14-9-17.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ResourceDB;
@class ActivitiesModel;

@interface ActivitiesDB : NSManagedObject

@property (nonatomic, retain) NSString * activitiesId;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *imgAry;  //这里面装的都是Resource

- (ActivitiesDB *)fromModel:(ActivitiesModel *)model;
- (ActivitiesModel *)toModel;
@end