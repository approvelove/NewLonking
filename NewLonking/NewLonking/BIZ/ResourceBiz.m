//
//  ResourceBiz.m
//  NewLonking
//
//  Created by 李健 on 14-10-14.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ResourceBiz.h"
#import "ResourceService.h"
#import "ResourceModel.h"
#import "ResourceDAO.h"
#import "FileHelper.h"

@implementation ResourceBiz
+ (NSArray *)saveResourceImageDataWithImage:(UIImage *)aImage andFileName:(NSString *)fileName
{
    NSMutableArray *ary = [@[] mutableCopy];
    if (aImage) {
        [ary addObject:aImage];
        [FileHelper storeFileInDefaultPathWithFileName:fileName andData:UIImageJPEGRepresentation(aImage, 1.f)];
    }
    return ary;
}

+ (void)startLoadImageDataFromServiceWithResourceModel:(ResourceModel *)resourceModel
{
    [ResourceService sendRequestDownloadResourceWithResourceName:resourceModel.name andResourceType:resourceModel.type];
}

+ (void)startLoadResouceListDataFromServiceWithTimes:(NSString *)times
{
    long long recordTimes = [times longLongValue];
    [ResourceService sendRequestGetResourceList:recordTimes];
}

+ (NSArray *)saveResourceListDataWithArray:(NSArray *)aArray
{
    NSAssert(aArray != nil, @"method saveResourceListDataWithArray has failed!");
    NSMutableArray *tempAry = [@[] mutableCopy];
    [aArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        ResourceModel *emModel = [ResourceModel loadFromService:obj];
        if (![ResourceDAO findById:emModel.modelId]) {
            if ([emModel.valid isEqualToString:@"0"]) {
                [ResourceDAO save:emModel];
            }
        }
        else
        {
            if ([emModel.valid isEqualToString:@"0"]) {
                [ResourceDAO update:emModel];
            }
            else
            {
                [ResourceDAO deleteById:emModel.modelId];
            }
        }
        if ([emModel.valid isEqualToString:@"0"]) {
            [tempAry addObject:emModel];
        }
    }];
    return tempAry;

}
@end
