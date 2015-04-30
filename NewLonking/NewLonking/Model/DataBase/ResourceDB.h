//
//  ResourceDB.h
//  Pods
//
//  Created by 李健 on 14-9-17.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class ResourceModel;


@interface ResourceDB : NSManagedObject

@property (nonatomic, retain) NSString * resourceId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;

- (ResourceDB *)fromModel:(ResourceModel *)model;

- (ResourceModel *)toModel;
@end
