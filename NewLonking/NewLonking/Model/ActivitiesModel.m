//
//  ActivitiesModel.m
//  NewLonking
//
//  Created by 李健 on 14-9-15.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ActivitiesModel.h"
#import "ResourceModel.h"

@implementation ActivitiesModel

@synthesize type,imgAry;

+ (instancetype)loadFromService:(NSDictionary *)aObj
{
    NSAssert(aObj !=nil, @"aObj can't be nil");
    ActivitiesModel *model = [[ActivitiesModel alloc] init];
    NSString *obj_activityid = [aObj[@"activityid"] stringValue];
    NSString *obj_type = aObj[@"type"];
    NSString *obj_valid= aObj[@"valid"];
    NSString *obj_creator = aObj[@"creator"];
    NSString *obj_updator = aObj[@"updator"];
    NSString *obj_updateTime = [aObj[@"updateTime"] stringValue];
    
    if (![VerifyHelper isEmpty:obj_activityid]) {
        model.modelId = obj_activityid;
    }
    if (![VerifyHelper isEmpty:obj_type]) {
        model.type = obj_type;
    }
    if (![VerifyHelper isEmpty:obj_valid]) {
        model.valid = obj_valid;
    }
    if (![VerifyHelper isEmpty:obj_creator]) {
        model.creator = obj_creator;
    }
    if (![VerifyHelper isEmpty:obj_updator]) {
        model.updator = obj_updator;
    }
    if (![VerifyHelper isEmpty:obj_updateTime]) {
        model.updateTime = obj_updateTime;
    }
    return model;
}

- (ActivitiesModel *)loadResourceArrayFromService:(NSArray *)aObj
{
    [aObj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@", aObj[idx]);
    }];
    
    NSAssert(aObj !=nil, @"aObj can't be nil");
    if (self) {
        NSMutableArray *tempAry = [@[] mutableCopy];
        aObj = [aObj sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
            NSString * ord_one = [obj1[@"index"] stringValue];
            NSString * ord_two = [obj2[@"index"] stringValue];
            if ([ord_one intValue] < [ord_two intValue]) {
                return NSOrderedAscending;
            }
            else
            {
                return NSOrderedDescending;
            }
        }];
        
        for (int i=0; i<aObj.count; i++) {
            NSDictionary *obj = aObj[i];
            NSDictionary *activityDict = obj[@"activity"];
            NSAssert(activityDict != nil, @"this obj from service not nomarl!");
            NSString *activity_id = [activityDict[@"activityid"] stringValue];
            if ([self.modelId isEqual:activity_id]) {
                NSDictionary *resourceDict = obj[@"resource"];
                if (resourceDict != nil) {
                    ResourceModel *resModel = [ResourceModel loadFromService:resourceDict];
                    if ([resModel.valid isEqualToString:@"0"]) {
                        if ([resModel.valid isEqualToString:@"0"]) {
                            [tempAry addObject:resModel];
                        }
                    }
                }
            }
        }
        
        if (!self.imgAry) {
            self.imgAry = tempAry;
        }
        else
        {
            NSMutableArray *resultAry = [@[] mutableCopy];
            [resultAry addObjectsFromArray:self.imgAry];
            NSMutableArray *newArray = [tempAry mutableCopy];
            for (int i =0; i<tempAry.count; i++) {
                ResourceModel *resModel = tempAry[i];
                for(int j=0; j<self.imgAry.count; j++) {
                    ResourceModel *selModel = self.imgAry[j];
                    if ([selModel.modelId isEqual:resModel.modelId]) {
                        [newArray removeObject:selModel];
                    }
                }
                [resultAry addObjectsFromArray:newArray];
            }
            self.imgAry = resultAry;
        }
    }
    return self;
}

@end
