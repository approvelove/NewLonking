
//
//  AboutModel.m
//  NewLonking
//
//  Created by 李健 on 14-9-14.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "AboutModel.h"
#import "ResourceModel.h"

@implementation AboutModel

@synthesize content,type,imgAry;

+ (instancetype)loadFromService:(NSDictionary *)aObj
{
    NSAssert(aObj !=nil, @"aObj can't be nil");
    AboutModel *model = [[AboutModel alloc] init];
    NSString *obj_aboutid = [aObj[@"aboutid"] stringValue];
    NSString *obj_content = aObj[@"content"];
    NSString *obj_type = aObj[@"type"];
    NSString *obj_updateTime = [aObj[@"updateTime"] stringValue];
    NSString *obj_valid = aObj[@"valid"];
    
    if (![VerifyHelper isEmpty:obj_aboutid]) {
        model.modelId = obj_aboutid;
    }
    if (![VerifyHelper isEmpty:obj_content]) {
        model.content = obj_content;
    }
    if (![VerifyHelper isEmpty:obj_type]) {
        model.type = obj_type;
    }
    if (![VerifyHelper isEmpty:obj_updateTime]) {
        model.updateTime = obj_updateTime;
    }
    if (![VerifyHelper isEmpty:obj_valid]) {
        model.valid = obj_valid;
    }
    return model;
}

- (AboutModel *)loadResourceArrayFromService:(NSArray *)aObj
{
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
        for (int i =0; i< aObj.count; i++) {
            NSDictionary *obj = aObj[i];
            NSDictionary *aboutDict = obj[@"about"];
            NSAssert(aboutDict != nil, @"this obj from service not nomarl!");
            NSString *about_id = [aboutDict[@"aboutid"] stringValue];
            if ([self.modelId isEqual:about_id]) {
                NSDictionary *resourceDict = obj[@"resource"];
                if (resourceDict != nil) {
                    ResourceModel *resModel = [ResourceModel loadFromService:resourceDict];
                    if ([resModel.valid isEqualToString:@"0"]) {
                        [tempAry addObject:resModel];
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
