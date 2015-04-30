//
//  ProductBiz.m
//  NewLonking
//
//  Created by 李健 on 14-10-16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ProductBiz.h"
#import "ProductService.h"
#import "ProductsDAO.h"
#import "HotProductDAO.h"
#import "ProductTypeDAO.h"

#import "HotProductModel.h"
#import "Products.h"
#import "ProductTypeModel.h"

@implementation ProductBiz

+ (NSArray *)saveHotProductDataWithArray:(NSArray *)aArray
{
    NSAssert(aArray != nil, @"method saveHotProductDataWithArray has failed!");
    NSMutableArray *tempAry = [@[] mutableCopy];
    [aArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        HotProductModel *emModel = [HotProductModel loadFromService:obj];
        if (![HotProductDAO findById:emModel.modelId]) {
            if ([emModel.valid isEqualToString:@"0"]) {
                [HotProductDAO save:emModel];
            }
        }
        else
        {
            if ([emModel.valid isEqualToString:@"0"]) {
                [HotProductDAO update:emModel];
            }
            else
            {
                [HotProductDAO deleteById:emModel.modelId];
            }
        }
        if ([emModel.valid isEqualToString:@"0"]) {
            [tempAry addObject:emModel];
        }
    }];
    return tempAry;
}

+ (NSArray *)saveProductDataWithArray:(NSArray *)aArray
{
    NSAssert(aArray != nil, @"method saveProductDataWithArray has failed!");
    NSMutableArray *tempAry = [@[] mutableCopy];
    [aArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        Products *emModel = [Products loadFromService:obj];
        if (![ProductsDAO findById:emModel.modelId]) {
            if ([emModel.valid isEqualToString:@"0"]) {
                [ProductsDAO save:emModel];
            }
        }
        else
        {
            if ([emModel.valid isEqualToString:@"0"]) {
                [ProductsDAO update:emModel];
            }
            else
            {
                [ProductsDAO deleteById:emModel.modelId];
            }
        }
        if ([emModel.valid isEqualToString:@"0"]) {
            [tempAry addObject:emModel];
        }
    }];
    return tempAry;
} 

+ (NSArray *)saveProductTypeDataWithArray:(NSArray *)aArray
{
    NSAssert(aArray != nil, @"method saveProductTypeDataWithArray has failed!");
    NSMutableArray *tempAry = [@[] mutableCopy];
    [aArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        ProductTypeModel *emModel = [ProductTypeModel loadFromService:obj];
        if (![ProductTypeDAO findById:emModel.modelId]) {
            if ([emModel.valid isEqualToString:@"0"]) {
                [ProductTypeDAO save:emModel];
            }
        }
        else
        {
            if ([emModel.valid isEqualToString:@"0"]) {
                [ProductTypeDAO update:emModel];
            }
            else
            {
                [ProductsDAO deleteById:emModel.modelId];
            }
        }
        if ([emModel.valid isEqualToString:@"0"]) {
            [tempAry addObject:emModel];
        }
    }];
    return tempAry;
}

+ (void)startLoadHotProductDataFromServiceWithWithTimes:(NSString *)times
{
    long long recordTimes = [times longLongValue];
    [ProductService sendRequestGetHotProduct:recordTimes];
}

+ (void)startLoadProductsDataFromServiceWithWithTimes:(NSString *)times
{
    long long recordTimes = [times longLongValue];
    [ProductService sendRequestGetProduct:recordTimes];
}

+ (void)startLoadProductTypeDataFromServiceWithWithTimes:(NSString *)times
{
    long long recordTimes = [times longLongValue];
    [ProductService sendRequestGetProductType:recordTimes];
}
@end
